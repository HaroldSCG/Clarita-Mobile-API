import 'dart:math';
import 'package:flutter/widgets.dart';

class Responsive {
  final double width;
  final double height;
  final double inch;

  Responsive(this.width, this.height, this.inch);

  factory Responsive.of(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final inch = sqrt(size.width * size.width + size.height * size.height);

    return Responsive(size.width, size.height, inch);
  }

  double wp(double percent) => width * percent / 100;
  double hp(double percent) => height * percent / 100;
}
