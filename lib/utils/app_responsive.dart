import 'package:flutter/material.dart';

class AppResponsive extends StatelessWidget {
  final Widget? mobileWeb;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? mobile;

  const AppResponsive({
    Key? key,
    @required this.mobileWeb,
    this.tablet,
    @required this.desktop,
    this.mobile,
  }) : super(key: key);

  /// checking web running on ....
  static bool isMobile(context) => MediaQuery.of(context).size.width <= 650;
  static bool isMobileWeb(context) =>
      MediaQuery.of(context).size.width < 900 &&
      MediaQuery.of(context).size.width > 650;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 900;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop!;
    } else if (isTablet(context) && tablet != null) {
      return tablet!;
    } else if (isMobileWeb(context)) {
      return mobileWeb!;
    } else {
      return mobile!;
    }
  }
}
