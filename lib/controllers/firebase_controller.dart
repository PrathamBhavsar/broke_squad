import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contri_buter/models/subscription.dart';
import 'package:contri_buter/models/transaction.dart';
import 'package:contri_buter/models/user.dart';
import 'package:contri_buter/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  static final FirebaseController instance = FirebaseController._privateConstructor();
  FirebaseController._privateConstructor();
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  CollectionReference transactionCollection = FirebaseFirestore.instance.collection('transactions');
  CollectionReference subscriptionCollection =
      FirebaseFirestore.instance.collection('subscriptions');

  Future<void> saveUser(UserModel userModel) async =>
      await userCollection.doc(userModel.phoneNumber).set(userModel.toJson());

  Future<UserModel?> getUser(String uid) async {
    logEvent(str: 'Fetching $uid');
    return UserModel.fromJson((await userCollection.doc(uid).get()).data() as Map<String, dynamic>);
  }

  Future<void> saveTransaction(TransactionModel transaction) async =>
      transactionCollection.add(transaction.toJson());

  Future<List<TransactionModel>> getTransactions() async {
    List<TransactionModel> result = [];
    List<QueryDocumentSnapshot<Object?>> response = (await transactionCollection
            .where('createdBy',
                isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber.toString())
            .get())
        .docs;
    for (var json in response) {
      result.add(TransactionModel.fromFirestore(json));
    }
    return result;
  }

  Future<void> saveSubscription(Subscription subscription) async => await subscriptionCollection
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber!.toString())
      .set(subscription.toJson());

  Future<Subscription> getSubscription() async =>
      Subscription.fromJson((await subscriptionCollection
              .doc(FirebaseAuth.instance.currentUser!.phoneNumber!.toString())
              .get())
          .data() as Map<String, dynamic>);
}
