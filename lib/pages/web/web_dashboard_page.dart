import 'package:arfriendv2/pages/web/web_side_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/app_responsive.dart';

class WebDashboardPage extends StatelessWidget {
  const WebDashboardPage({
    super.key,
    required this.widget,
    required this.route,
  });

  final Widget widget;
  final String route;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff004B7B),
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 0,
        title: Image.asset(
          "assets/images/logo.webp",
          width: 200,
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height,
            child: Image.asset(
              "assets/images/bg.webp",
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              if (!AppResponsive.isMobile(context))
                Expanded(
                  flex: 1,
                  child: SideNavbar(route: route),
                ),
              Expanded(
                flex: 5,
                child: widget,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
