import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;

  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;
}