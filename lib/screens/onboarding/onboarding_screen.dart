import 'package:contri_buter/constants/colors.dart';
import 'package:contri_buter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Map<String, String>> captions = [
    {
      "title": "Fair Share, No Fuss",
      "subtitle":
          "Easily split the bill with friends and make every outing stress-free."
    },
    {
      "title": "Split Smart, Stay Social",
      "subtitle":
          "No more awkward math - just simple, quick bill splitting with your crew."
    },
    {
      "title": "Friends, Fun, and Fairness",
      "subtitle": "Enjoy your time together, we'll handle the bill."
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: OnBoardingSlider(
        finishButtonText: 'Login',
        onFinish: () {
          context.goNamed('login');
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        controllerColor: kPrimaryColor,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        centerBackground: true,
        background: [
          for (int i = 1; i < 4; i++)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Image.asset(
                'assets/slide_$i.png',
                height: 400,
              ),
            )
        ],
        speed: 1.8,
        pageBodies: [
          for (int i = 0; i < 3; i++)
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    captions[i]['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    captions[i]['subtitle']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      )),
    );
  }
}
