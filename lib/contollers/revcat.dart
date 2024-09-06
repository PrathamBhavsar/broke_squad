import 'package:contri_buter/contollers/firebase_controller.dart';
import 'package:contri_buter/models/subscription.dart';
import 'package:contri_buter/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

abstract class RevCat {
  static String apiKey = '';

  static Future<void> initSDK() async => await Purchases.configure(PurchasesConfiguration(apiKey));

  static Future<void> onSuccess() async {
    await Purchases.setPhoneNumber(FirebaseAuth.instance.currentUser!.phoneNumber!);
    String key = 'no_id';
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      key = customerInfo.activeSubscriptions.first;
      String createdDate = customerInfo.allPurchaseDates[key]!;
      String expiryDate = customerInfo.allExpirationDates[key]!;

      String name = key == 'weekly:weekly' ? 'Weekly Plan' : (key == "monthly:monthly" ? "Monthly Plan" : "Yearly Plan");
      Subscription subscription = Subscription(id: key, name: name, createdAt: DateTime.parse(createdDate), expireAt: DateTime.parse(expiryDate), isActive: true);
      await FirebaseController.instance.saveSubscription(subscription);
    } catch (e) {
      logError(str: 'Error in RevCat');
    }
  }

  static void onFailure() => logError(str: 'failed RevCat paywall');

  static void onError() => logError(str: 'error RevCat paywall');
}
