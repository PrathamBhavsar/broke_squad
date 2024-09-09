import 'dart:convert';

import 'package:animated_emoji/animated_emoji.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/controllers/revcat.dart';
import 'package:contri_buter/models/subscription.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Subscription subscription = Subscription(id: 'monthly:monthly', name: 'Monthly Plan', createdAt: DateTime.now(), expireAt: DateTime.now().add(Duration(days: 30)), isActive: true);

  _manageInAppPurchase() async {
    PaywallResult result = await RevenueCatUI.presentPaywall(displayCloseButton: true);
    if (result == PaywallResult.purchased)
      await RevCat.onSuccess();
    else if (result == PaywallResult.error)
      RevCat.onError();
    else if (result == PaywallResult.cancelled)
      RevCat.onFailure();
    else
      logEvent(str: 'result: ${result.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAuthTextFieldColor,
      appBar: AppBar(
        backgroundColor: AppColors.kAuthTextFieldColor,
        leading: IconButton(
          onPressed: () {
            context.goNamed('home');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: AppPaddings.scaffoldPadding,
        child: Center(
          child: Column(
            children: [
              FutureBuilder<String?>(
                future: UserProvider.instance.getProfileImage(),
                builder: (context, snapshot) {
                  logEvent(str: snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ClipOval(
                        child: Container(
                          height: getWidth(context) * 0.4,
                          width: getWidth(context) * 0.4,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error);
                  } else if (snapshot.hasData) {
                    final profileImageUrl = snapshot.data;
                    return ClipOval(
                        child: CachedNetworkImage(
                      imageUrl: profileImageUrl ??
                          "https://firebasestorage.googleapis.com/v0/b/fitmotive-9564c.appspot.com/o/user-icon-on-transparent-background-free-png.webp?alt=media&token=60700768-4bc0-4883-9c4d-104e23fad732",
                      width: getWidth(context) * 0.4,
                      fit: BoxFit.cover,
                    ));
                  } else {
                    return Container(
                        width: getWidth(context),
                        child: Icon(
                          Icons.account_circle,
                        ));
                  }
                },
              ),
              spaceH20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hey! ", style: AppTextStyles.kOnboardingTitleTextStyle),
                  AnimatedEmoji(
                    AnimatedEmojis.wave,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    UserProvider.instance.user == null ? "" : UserProvider.instance.user!.userName,
                    style: AppTextStyles.kOnboardingTitleTextStyle,
                  ),
                ],
              ),
              spaceH20(),
              if (true) ...[
                Card(
                  color: AppColors.kPrimaryColor,
                  elevation: 1.2,
                  child: ListTile(
                    title: Text(
                      "You are Pro! ${AnimatedEmojis.partyingFace.toUnicodeEmoji()}",
                      style: AppTextStyles.kOnboardingTitleTextStyle
                          .copyWith(color: AppColors.kAuthTextFieldColor),
                    ),
                    subtitle: Text("${subscription.name}\nUntil: ${subscription.expireAt.day}, ${DateFormat('MMMM').format(subscription.expireAt)}",
                        style: AppTextStyles.kOnboardingTitleTextStyle
                            .copyWith(color: AppColors.kAuthTextFieldColor)),
                  ),
                ),
                Spacer(),
              ] else ...[
                Flexible(
                    child: Lottie.asset(
                  'assets/lottie.json',
                  backgroundLoading: true,
                )),
                spaceH10(),
                Text(
                  'Get Premium Now!',
                  style: AppTextStyles.kOnboardingTitleTextStyle,
                ),
              ],
              spaceH10(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: true
                            ? _manageInAppPurchase
                            : () => {
                                  //_launchMyUrl(
                                  //'https://play.google.com/store/account/subscriptions')
                                },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          backgroundColor: AppColors.kDarkColor,
                        ),
                        child: Text(
                          true ? 'Get Subscription' : 'Manage Subscription',
                          style: AppTextStyles.poppins.copyWith(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              spaceH20(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          backgroundColor: AppColors.kPrimaryColor,
                        ),
                        child: Text(
                          'Sign Out',
                          style: AppTextStyles.poppins.copyWith(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              spaceH20(),
            ],
          ),
        ),
      ),
    );
  }
}
