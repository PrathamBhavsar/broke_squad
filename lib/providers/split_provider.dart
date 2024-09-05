import 'package:contri_buter/models/contacts.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplitProvider extends ChangeNotifier {
  List<Contact> allContacts = [];
  List<Contact> selectedContacts = [];
  String billName = '';
  String billAmount = '';
  String billCategory = '';
  int currentIndex = 0;
  List<String> abbBarTitles = ['Add People','Create Bill'];
  // TODO: later update it with transaction.dart

  SplitProvider._privateConstructor();
  static final SplitProvider instance = SplitProvider._privateConstructor();
  getContact() {
    allContacts =  [
      Contact(name: "Alice Johnson", phNo: "+91 1234567890"),
      Contact(name: "Bob Smith", phNo: "+91 9876543210"),
      Contact(name: "Charlie Brown", phNo: "+91 7890123456"),
      Contact(name: "David Lee", phNo: "+91 6789012345"),
      Contact(name: "Emily Taylor", phNo: "+91 5678901234"),
      Contact(name: "Frank Wilson", phNo: "+91 4567890123"),
      Contact(name: "Grace Williams", phNo: "+91 3456789012"),
      Contact(name: "Henry Baker", phNo: "+91 2345678901"),
      Contact(name: "Isabella Clark", phNo: "+91 1234567890"),
      Contact(name: "Jack Brown", phNo: "+91 9876543210"),
    ];
    notifyListeners();
  }

  addContact(Contact contact) {selectedContacts.add(contact); notifyListeners();}
  removeContact(Contact contact) {selectedContacts.remove(contact);}
  setBillName(String str) {billName = str; }
  setBillAmount(String str) {billAmount = str; }
  setBillCategory(String str) {billCategory = str; notifyListeners();}

  manageContinue(context, [Function? setParams]) {
    if (currentIndex == 0) {
      selectedContacts.isEmpty ? Fluttertoast.showToast(msg: 'Add People to Continue') : currentIndex++;
    } else if(currentIndex == 1) {
      setParams != null ? setParams() : null;
      logEvent(str: 'Saved $billName $billAmount $billCategory ${ int.parse(billAmount)/selectedContacts.length}');
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

  onDispose() {
    allContacts.clear();
    selectedContacts.clear();
    currentIndex = 0;
    billName = '';
    billAmount= '';
    billCategory = '';

  }
}