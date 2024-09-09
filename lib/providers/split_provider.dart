import 'package:contri_buter/controllers/firebase_controller.dart';
import 'package:contri_buter/models/contacts.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplitProvider extends ChangeNotifier {
  List<MyContact> allContacts = [];
  List<MyContact> displayContacts = [];
  List<MyContact> selectedContacts = [];
  String billName = '';
  String billAmount = '';
  String billCategory = '';
  int currentIndex = 0;
  List<MyContact> payers = [];
  Map<MyContact, TextEditingController> _contributionControllers = {};
  List<String> abbBarTitles = ['Add People', 'Create Bill', 'Who Paid'];
  double amountPerPayer = 0;

  SplitProvider._privateConstructor();
  static final SplitProvider instance = SplitProvider._privateConstructor();

  Future<void> getContact() async {
    List<MyContact> myContacts = [];
    bool check = await FlutterContacts.requestPermission();

    if (check) {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      contacts.isEmpty
          ? logEvent(str: 'Empty')
          : {
              for (int i = 0; i < contacts.length; i++)
                {
                  for (int j = 0; j < contacts[i].phones.length; j++)
                    {
                      myContacts.add(MyContact(
                          name: contacts[i].displayName,
                          phNo: contacts[i].phones[j].normalizedNumber))
                    }
                }
            };
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
                element.name.toLowerCase().contains(str.toLowerCase()) ||
                element.phNo.contains(str),
          )
          .toList();
    }
    notifyListeners();
  }

  addContact(MyContact contact) {
    selectedContacts.add(contact);
    notifyListeners();
  }

  removeContact(MyContact contact) {
    selectedContacts.remove(contact);
    notifyListeners();
  }

  void addPayer(MyContact contact) {
    if (!payers.contains(contact)) {
      payers.add(contact);
      _contributionControllers[contact] = TextEditingController();
      _distributeEqualAmounts();
      notifyListeners();
    }
  }

  void removePayer(MyContact contact) {
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
      _contributionControllers[contact]?.text =
          amountPerPayer.toStringAsFixed(2);
    }
  }

  setBillAmount(String str) {
    billAmount = str;
    _distributeEqualAmounts(); // Recalculate the distribution whenever the bill amount changes
    notifyListeners();
  }

  void updateContributions(MyContact editedContact, String editedAmount) {
    double totalBillAmount = double.parse(billAmount);
    double editedAmountValue = double.tryParse(editedAmount) ?? 0.0;

    double remainingAmount = totalBillAmount - editedAmountValue;
    int remainingPayers = payers.length - 1;

    if (remainingPayers > 0) {
      amountPerPayer =
          remainingAmount / remainingPayers; // Update the amountPerPayer
      for (var contact in payers) {
        if (contact != editedContact) {
          _contributionControllers[contact]?.text =
              amountPerPayer.toStringAsFixed(2);
        }
      }
    }

    notifyListeners();
  }

  String getHintText(MyContact contact) {
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

  _save() async {
    TransactionModel transactionModel = TransactionModel(
        id: '-1',
        createdBy: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        title: billName,
        amount: double.parse(billAmount),
        category: billCategory,
        contributors: TransactionModel.peopleFromList(selectedContacts,
            double.parse(billAmount) / (selectedContacts.length + 1)),
        unpaidParticipants: TransactionModel.peopleFromList(selectedContacts,
            double.parse(billAmount) / (selectedContacts.length + 1)),
        dateTime: DateTime.now());
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
