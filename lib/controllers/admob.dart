import 'package:contri_buter/utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob {
  static const String interstitialAdUnitId = "ca-app-pub-2937476914243605/8353069752";
  static final AdMob instance = AdMob._();
  AdMob._();
  InterstitialAd? interstitialAd;

  Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (error) {
            logError(str: error.toString());
            interstitialAd = null;
          },
        ));
  }

  Future<void> showInterstitialAd() async {
    if (interstitialAd == null) {
      logEvent(str: 'its null');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        logEvent(str: 'Showing...');
      },
      onAdDismissedFullScreenContent: (ad) => logEvent(str: 'Dismissed...'),
      onAdFailedToShowFullScreenContent: (ad, error) => logError(str: error.toString()),
      onAdClicked: (ad) => logEvent(str: 'clicked!...'),
    );
    await interstitialAd!.show();
    interstitialAd= null;
  }
}
