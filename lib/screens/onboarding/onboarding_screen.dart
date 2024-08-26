import 'package:contri_buter/constants/UI.dart';
import 'package:contri_buter/constants/routes.dart';
import 'package:contri_buter/providers/navigation_provider.dart';
import 'package:contri_buter/screens/onboarding/widgets/dot_indicator_widget.dart';
import 'package:contri_buter/screens/onboarding/widgets/pages_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPaddings.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 416,
              child: PageView.builder(
                controller: _pageController,
                itemCount:
                OnboardingScreens().screens.length, // Set the item count
                itemBuilder: (context, index) {
                  return OnboardingScreens()
                      .screens[index]; // Access the list of widgets
                },
              ),
            ),
            SizedBox(height: 10),
            DotsIndicator(
              controller: _pageController,
              itemCount: OnboardingScreens().screens.length,
            ),
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SkipButton(pageController: _pageController),
                NextButton(pageController: _pageController),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  final PageController pageController;

  const SkipButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(
          pageController.positions.first.maxScrollExtent.toInt(),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        height: 60,
        width: 100,
        child: Center(
          child: Text(
            'Skip',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.accentColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final PageController pageController;

  const NextButton({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int currentPage = pageController.page?.toInt() ?? 0;
        if (currentPage < OnboardingScreens().screens.length - 1) {
          pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          Provider.of<NavigationProvider>(context, listen: false)
              .navigateTo(context, Routes.login);
        }
      },
      child: Container(
        height: 60,
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Icon(
          Icons.arrow_forward_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
