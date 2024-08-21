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
          PageView.builder(
            itemCount: OnboardingScreens().screens.length, // Set the item count
            itemBuilder: (context, index) {
              return OnboardingScreens()
                  .screens[index]; // Access the list of widgets
            },
          ),
          SizedBox(height: 10),

          Row(
            children: [
              BackButton(),
              NextButton(),
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
          child: SvgPicture.asset(
            'assets/your_image.svg', // Replace with your actual asset path
          ),
        ),
        SizedBox(height: 10),
        Text('Splitting the costs among friends is easy!'),
        Text('Enjoy hassle-free cost sharing with friends.'),
      ],
    ),
    Column(
      children: [
        Container(
          height: 300,
          child: SvgPicture.asset(
            'assets/another_image.svg', // Replace with another asset path
          ),
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
          child: SvgPicture.asset(
            'assets/another_image.svg', // Replace with another asset path
          ),
        ),
        SizedBox(height: 10),
        Text('Track your spending with ease!'),
        Text('Monitor your expenses effortlessly.'),
      ],
    ),
    // Add more screens as needed
  ];
}

class BackButton extends StatelessWidget {
  final pageController;

  const BackButton({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class NextButton extends StatelessWidget {
  final pageController;

  const NextButton({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OnboardingScreens()
            .screens[next]
      },
      child: Container(
        height: 100,
        width: 150,
        child: Text('Next'),
      ),
    );
  }
}
