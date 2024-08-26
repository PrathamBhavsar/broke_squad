import 'package:flutter/material.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,

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
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Splitting the costs among friends is easy!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text('Enjoy hassle-free cost sharing with friends.'),
            ],
          ),
        )
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
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Splitting the costs among friends is easy!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text('Enjoy hassle-free cost sharing with friends.'),
            ],
          ),
        )
      ],
    ),
    // Add more screens as needed
  ];
}
