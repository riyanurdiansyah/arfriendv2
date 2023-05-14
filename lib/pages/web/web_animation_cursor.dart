import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebAnimationCursor extends StatefulWidget {
  const WebAnimationCursor({Key? key}) : super(key: key);

  @override
  State<WebAnimationCursor> createState() => _WebAnimationCursorState();
}

class _WebAnimationCursorState extends State<WebAnimationCursor>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..repeat(reverse: true);
    animation = CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn);

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
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
      child: FadeTransition(
        opacity: animation!,
        child: Container(
          width: 14,
          height: 25,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
