import 'package:flutter/material.dart';

import '../../utils/app_responsive.dart';
import '../../utils/app_text.dart';
import 'web_side_bar.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({
    super.key,
    required this.route,
  });

  final String route;

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppResponsive.isMobile(context)
          ? SideNavbar(route: widget.route)
          : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xff004B7B),
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFFDAF0FF),
        title: AppText.labelW600(
          "Home",
          18,
          Colors.black,
        ),
      ),
    );
  }
}
