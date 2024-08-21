import 'package:flutter/material.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(itemBuilder: (context, index) {
        return pages[index];
      },),
    );
  }
}

class OnboardingScreens {
  final screens = <Widget>[

  ];

  Widget( ) {
      return
      Column(
        children: [
          Text('Splitting the costs among friends is easy!'),
        ],
      );}
}