import 'package:contri_buter/models/contacts.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/utils.dart';
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
  List<String> abbBarTitles = ['Add People', 'Create Bill'];
  // TODO: later update it with transaction.dart

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
            (element) => element.name.toLowerCase().contains(str.toLowerCase()) || element.phNo.contains(str),
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
  }

  setBillName(String str) {
    billName = str;
  }

  setBillAmount(String str) {
    billAmount = str;
  }

  setBillCategory(String str) {
    billCategory = str;
    notifyListeners();
  }

  manageContinue(context, [Function? setParams]) {
    if (currentIndex == 0) {
      selectedContacts.isEmpty
          ? Fluttertoast.showToast(msg: 'Add People to Continue')
          : currentIndex++;
    } else if (currentIndex == 1) {
      setParams != null ? setParams() : null;
      _save();
      Fluttertoast.showToast(msg: 'Transaction Created!');
      Navigator.pop(context);
    } else {
      currentIndex = 0;
    }
    notifyListeners();
  }

  manageBack(context) {
    currentIndex == 0 ? Navigator.pop(context) : currentIndex--;
    notifyListeners();
  }

  _save() async {
    TransactionModel transactionModel = TransactionModel(id: '-1',title: billName,amount: double.parse(billAmount),category: billCategory,contributors: TransactionModel.peopleFromList(selectedContacts, double.parse(billAmount)/(selectedContacts.length+1)),unpaidParticipants: TransactionModel.peopleFromList(selectedContacts, double.parse(billAmount)/(selectedContacts.length+1)),dateTime: DateTime.now());
    logEvent(str: "${transactionModel.toString()}");
    // call firebase to save transaction
  }
  onDispose() {
    displayContacts.clear();
    selectedContacts.clear();
    currentIndex = 0;
    billName = '';
    billAmount = '';
    billCategory = '';
  }
}
