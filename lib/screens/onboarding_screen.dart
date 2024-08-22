import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Column(
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
          Row(
            children: [
              SkipButton(pageController: _pageController),
              NextButton(pageController: _pageController),
            ],
          )
        ],
      ),
    );
  }
}

class OnboardingScreens {
  final List<Widget> screens = [
    Column(
      children: [
        Container(
          height: 300,
          color: Colors.red,
          // child:
          // SvgPicture.asset(
          //   'first_onb.svg', // Replace with your actual asset path
          // ),
        ),
        SizedBox(height: 10),
        Flexible(
          child: Column(
            children: [
              Text(
                'Splitting the costs among friends is easy!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text('Enjoy hassle-free cost sharing with friends.'),
            ],
          ),
        ),
      ],
    ),
    Column(
      children: [
        Container(
          height: 300,
          color: Colors.blue,
          // child:
          // SvgPicture.asset(
          //   'assets/another_image.svg', // Replace with another asset path
          // ),
        ),
        SizedBox(height: 10),
        Text('Track your spending with ease!'),
        Text('Monitor your expenses effortlessly.'),
      ],
    ),
    Column(
      children: [
        Container(
          height: 300,
          color: Colors.green,
          // child: SvgPicture.asset(
          //   'assets/another_image.svg', // Replace with another asset path
          // ),
        ),
        SizedBox(height: 10),
        Text('Track your spending with ease!'),
        Text('Monitor your expenses effortlessly.'),
      ],
    ),
    // Add more screens as needed
  ];
}

class SkipButton extends StatelessWidget {
  final pageController;

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
        height: 100,
        width: 150,
        child: Text(
          'Skip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    ;
  }
}

class NextButton extends StatelessWidget {
  final pageController;

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
        } else {}
      },
      child: Container(
          height: 75,
          width: 125,
          decoration: BoxDecoration(
              color: Ui.primaryColor,
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Icon(
            Icons.arrow_forward_sharp,
            color: Colors.white,
          )),
    );
  }
}
