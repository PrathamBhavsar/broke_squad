import 'package:animated_emoji/animated_emoji.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/controllers/revcat.dart';
import 'package:contri_buter/models/subscription.dart';
import 'package:contri_buter/providers/auth_provider.dart';
import 'package:contri_buter/providers/user_provider.dart';
import 'package:contri_buter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> appFeatures = [
    {"feature": "Unlimited Bills", "emoji": "📝"},
    {"feature": "No Ads", "emoji": "🚫"},
    // {"feature": "Split Unevenly", "emoji": "🤝💸"},
  ];

  Subscription subscription = Subscription(
      id: 'monthly:monthly',
      name: 'Monthly Plan',
      createdAt: DateTime.now(),
      expireAt: DateTime.now().add(Duration(days: 30)),
      isActive: false);

  _startInAppPurchase() async {
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

  _launchMyUrl(String url) async {
    await launchUrlString(url, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    subscription.isActive  = false;
    return Scaffold(
      backgroundColor: AppColors.kAuthTextFieldColor,
      appBar: AppBar(
        backgroundColor: AppColors.kAuthTextFieldColor,
      ),
      body: Padding(
        padding: AppPaddings.scaffoldPadding,
        child: Center(
          child: Column(
            children: [
              FutureBuilder<String?>(
                future: UserProvider.instance.getProfileImage(),
                builder: (context, snapshot) {

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
                        progressIndicatorBuilder: (context, url, progress) => Container(
                            width: getWidth(context) * 0.4,
                            height: getWidth(context) * 0.4,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: LinearProgressIndicator(
                              backgroundColor: AppColors.lightGrey,
                              color: AppColors.grey,
                              value: progress.progress,
                            )),
                      ),
                    );
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
              Card(
                color: AppColors.kPrimaryColor ,
                elevation: 1.2,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: subscription.isActive ? _buildSubscribedCard() : _buildNotSubscribedCard(),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: !subscription.isActive
                            ? _startInAppPurchase
                            : () => {
                                  _launchMyUrl(
                                      'https://play.google.com/store/account/subscriptions')
                                },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          backgroundColor: AppColors.kDarkColor,
                        ),
                        child: Text(
                          !subscription.isActive ? 'Get Subscription' : 'Manage Subscription',
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
                        onPressed: () => AuthProvider.instance.logout(context),
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

  _buildSubscribedCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You Are Pro!',
            style: AppTextStyles.kProfileScreenTextStyle.copyWith(fontSize: 22.sp),
          ),
          spaceH10(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Monthly Plan\n', style: AppTextStyles.kProfileScreenTextStyle),
                    TextSpan(
                        text:
                            'Expire on: ${subscription.expireAt.day}, ${DateFormat('MMMM').format(subscription.expireAt)}',
                        style: AppTextStyles.kProfileScreenTextStyle),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: subscription.isActive
                    ? () => _launchMyUrl('https://play.google.com/store/account/subscriptions')
                    : _startInAppPurchase(),
                child: Text(
                  subscription.isActive ? 'Manage' : 'Explore',
                  style: AppTextStyles.kProfileScreenTextStyle.copyWith(fontSize: 12.sp),
                ),
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(1.5),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.kSubColor,
                  ),
                ),
              )
            ],
          )
        ],
      );
  _buildNotSubscribedCard() => Column(
        children: [
          Text(
            'App Features',
            style: AppTextStyles.kProfileScreenTextStyle,
          ),
          spaceH20(),
          for (var feature in appFeatures)
            FeaturesTile(emoji: feature['emoji']!, title: feature['feature']!)
        ],
      );
}

class FeaturesTile extends StatelessWidget {
  const FeaturesTile({super.key, required this.emoji, required this.title});
  final String emoji;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            emoji,
            style: AppTextStyles.kProfileScreenTextStyle,
          ),
        ),
      ),
      title: Text(title, style: AppTextStyles.kProfileScreenTextStyle),
    );
  }
}
