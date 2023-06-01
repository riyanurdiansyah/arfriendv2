import 'package:arfriendv2/utils/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../utils/route_name.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    animation = CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn);
    Future.delayed(Duration.zero, () async {
      final user = FirebaseAuth.instance.currentUser;
      Future.delayed(const Duration(seconds: 3), () {
        if (user != null) {
          context.goNamed(RouteName.main);
        } else {
          context.goNamed(RouteName.masuk);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: colorPrimary.withOpacity(0.4),
      ),
      child: Scaffold(
        backgroundColor: colorPrimary,
        body: Center(
          child: FadeTransition(
            opacity: animation!,
            child: Image.asset(
              "assets/images/logo.webp",
              width: 360,
            ),
          ),
        ),
      ),
    );
  }
}
