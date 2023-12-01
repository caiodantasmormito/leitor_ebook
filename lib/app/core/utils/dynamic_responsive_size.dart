import 'package:flutter/material.dart';

class DynamicResponsiveSize {
  final Size mediaQueryData;

  DynamicResponsiveSize({required this.mediaQueryData});

  static DynamicResponsiveSize of(BuildContext context) =>
      DynamicResponsiveSize(mediaQueryData: MediaQuery.sizeOf(context));

  double dynamicScaleSize({required double size}) {
    final shortestSide = mediaQueryData.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;

    if (shortestSide > tabletXl) {
      return size * 1.25;
    } else if (shortestSide > tabletLg) {
      return size * 1.15;
    } else if (shortestSide > tabletSm) {
      return size * 1;
    } else if (shortestSide > phoneLg) {
      return size * .9;
    } else {
      return size * .85;
    }
  }

  double get height => mediaQueryData.height;
  double get width => mediaQueryData.width;

  bool isTablet() {
    final shortestSide = mediaQueryData.shortestSide;
    return shortestSide > 600;
  }

  bool isMini() {
    final shortestSide = mediaQueryData.shortestSide;
    return shortestSide <= 320;
  }
}
