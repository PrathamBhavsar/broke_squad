import 'package:contri_buter/controllers/firebase_controller.dart';
import 'package:contri_buter/models/member.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/models/user.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplitProvider extends ChangeNotifier {
  List<UserModel> allContacts = [];
  List<UserModel> displayContacts = [];
  List<UserModel> selectedContacts = [];
  String billName = '';
  String billAmount = '';
  String billCategory = '';
  int currentIndex = 0;
  List<UserModel> payers = [];
  Map<UserModel, TextEditingController> _contributionControllers = {};
  List<String> abbBarTitles = ['Add People', 'Create Bill', 'Who Paid'];
  double amountPerPayer = 0;

  SplitProvider._privateConstructor();
  static final SplitProvider instance = SplitProvider._privateConstructor();

  Future<void> getContact() async {
    List<String> myPhoneNum = [];

    List<UserModel> myContacts = [];
    bool check = await FlutterContacts.requestPermission();

    if (check) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      if (contacts.isNotEmpty)
        contacts.forEach(
          (contact) => contact.phones.forEach(
            (number) => myPhoneNum.add(
              number.number.replaceAll(" ", '').toString(),
            ),
          ),
        );

      myContacts = await FirebaseController.instance.getAppUsers(myPhoneNum);
      myContacts.removeWhere(
        (element) => element.phoneNumber == UserProvider.instance.user!.phoneNumber,
      );
    } else {
      logError(str: 'Not Allowed');
    }
    allContacts = myContacts;
    displayContacts = myContacts;
    notifyListeners();
  }

  filterContact(String str) {
    logEvent(str: 'mystr : $str');
    if (str.isEmpty) {
      displayContacts = allContacts;
    } else {
      displayContacts = allContacts
          .where(
            (element) =>
                element.userName.toLowerCase().contains(str.toLowerCase()) ||
                element.phoneNumber.contains(str),
          )
          .toList();
    }
    notifyListeners();
  }

  addContact(UserModel contact) {
    selectedContacts.add(contact);
    notifyListeners();
  }

  removeContact(UserModel contact) {
    selectedContacts.remove(contact);
    notifyListeners();
  }

  void addPayer(UserModel contact) {
    if (!payers.contains(contact)) {
      payers.add(contact);
      _contributionControllers[contact] = TextEditingController();
      _distributeEqualAmounts();
      notifyListeners();
    }
  }

  void removePayer(UserModel contact) {
    if (payers.contains(contact)) {
      payers.remove(contact);
      _contributionControllers.remove(contact);
      _distributeEqualAmounts();
      notifyListeners();
    }
  }

  void _distributeEqualAmounts() {
    if (payers.isEmpty || billAmount.isEmpty) return;
    amountPerPayer = double.parse(billAmount) / payers.length;

    for (var contact in payers) {
      _contributionControllers[contact]?.text = amountPerPayer.toStringAsFixed(2);
    }
  }

  setBillAmount(String str) {
    billAmount = str;
    _distributeEqualAmounts(); // Recalculate the distribution whenever the bill amount changes
    notifyListeners();
  }

  void updateContributions(UserModel editedContact, String editedAmount) {
    double totalBillAmount = double.parse(billAmount);
    double editedAmountValue = double.tryParse(editedAmount) ?? 0.0;

    double remainingAmount = totalBillAmount - editedAmountValue;
    int remainingPayers = payers.length - 1;

    if (remainingPayers > 0) {
      amountPerPayer = remainingAmount / remainingPayers; // Update the amountPerPayer
      for (var contact in payers) {
        if (contact != editedContact) {
          _contributionControllers[contact]?.text = amountPerPayer.toStringAsFixed(2);
        }
      }
    }

    notifyListeners();
  }

  String getHintText(UserModel contact) {
    return amountPerPayer.toStringAsFixed(2);
  }

  setBillName(String str) {
    billName = str;
    notifyListeners();
  }

  setBillCategory(String str) {
    billCategory = str;
    notifyListeners();
  }

  void manageContinue(BuildContext context, [Function? setParams]) {
    if (currentIndex == 0) {
      if (selectedContacts.isEmpty) {
        Fluttertoast.showToast(msg: 'Add People to Continue');
      } else {
        currentIndex++;
      }
    } else if (currentIndex == 1) {
      if (setParams != null) {
        setParams();
      }
      if (billName.isEmpty || billAmount.isEmpty) {
        Fluttertoast.showToast(msg: 'Enter Bill Name and Amount to Continue');
      } else {
        _distributeEqualAmounts();
        currentIndex++;
      }
    } else if (currentIndex == 2) {
      _save();
      Fluttertoast.showToast(msg: 'Transaction Created!');
      Navigator.pop(context);
    }
    notifyListeners();
  }

  manageBack(context) {
    currentIndex == 0 ? Navigator.pop(context) : currentIndex--;
    notifyListeners();
  }

  void _save() async {
    // Create a map for contributors and unpaid participants
    Map<String, dynamic> members = {};

    selectedContacts.forEach(
      (contact) {
        members[contact.phoneNumber] = Members(
                id: contact.phoneNumber,
                displayName: contact.userName,
                amount:
                    (double.parse(billAmount) / (selectedContacts.length + 1)).toStringAsFixed(2),
                profileImage: contact.profileImage,
                isPaid: false)
            .toJson();
      },
    );

    members[UserProvider.instance.user!.phoneNumber] = Members(
        id: UserProvider.instance.user!.phoneNumber,
        displayName: UserProvider.instance.user!.userName,
        amount: (double.parse(billAmount) / (selectedContacts.length + 1)).toStringAsFixed(2),
        profileImage: UserProvider.instance.user!.profileImage,
        isPaid: true).toJson();

    // Calculate the contributors' map
    // for (var contact in payers) {
    //   String phoneNumber = contact.phoneNumber;
    //
    //   // Get the contribution from the controller or use amountPerPayer if it's 0.00 or empty
    //   String controllerText = _contributionControllers[contact]?.text ?? '0.00';
    //   double contribution = double.tryParse(controllerText) ?? amountPerPayer;
    //
    // // 'amount': contribution.toStringAsFixed(2),
    // // 'name': contact.userName,
    // // 'profile_picture': contact.profileImage,
    //   contributors[phoneNumber] = Members(id: phoneNumber, amount: contribution.toStringAsFixed(2), profileImage: contact.profileImage, isPaid: false);
    // }

    // Calculate the unpaid participants' map (those who are not payers)
    // for (var contact in selectedContacts) {
    //   if (!payers.contains(contact)) {
    //     String phoneNumber = contact.phoneNumber;
    //     contributors[phoneNumber] = {
    //       'amount': '0.00',
    //       'name': contact.userName,
    //       'profile_picture': contact.profileImage,
    //     };
    //   }
    // }

    // Creating the TransactionModel with the new structure
    TransactionModel transactionModel = TransactionModel(
      id: '-1',
      createdBy: UserProvider.instance.user!,
      title: billName,
      amount: double.parse(billAmount),
      category: billCategory,
      members: members, // Use the newly created contributors map
      //unpaidParticipants: unpaidParticipants, // Use the newly created unpaid participants map
      dateTime: DateTime.now(),
    );

    // Log the event and save the transaction
    logEvent(str: "${transactionModel.toJson()}");
    await FirebaseController.instance.saveTransaction(transactionModel);
  }

  onDispose() {
    displayContacts.clear();
    selectedContacts.clear();
    payers.clear();
    _contributionControllers.clear();
    currentIndex = 0;
    billName = '';
    billAmount = '';
    billCategory = '';
    notifyListeners();
  }
}
