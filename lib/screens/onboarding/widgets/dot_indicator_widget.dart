import 'dart:math';

import 'package:contri_buter/constants/UI.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final double dotSize;
  final double dotSpacing;
  final double activeDotWidth;

  DotsIndicator({
    required this.controller,
    required this.itemCount,
    this.dotSize = 4.0,
    this.dotSpacing = 3.0,
    this.activeDotWidth = 24.0,
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List<Widget>.generate(itemCount, (index) {
        double selectedness = Curves.easeOut.transform(
          max(0.0, 1.0 - ((controller.page ?? controller.initialPage) - index).abs()),
        );
        double width = dotSize + (activeDotWidth - dotSize) * selectedness;

        return Container(
          width: width,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: dotSpacing / 2),
          decoration: BoxDecoration(
            color: selectedness > 0.5 ?  AppColors.primaryColor : AppColors.accentColor,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}
