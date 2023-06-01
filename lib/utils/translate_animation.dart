import 'package:flutter/material.dart';

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 100 * value),
        child: child,
      ),
      child: child,
    );
  }
}

class TranslateUpToDownAnimation extends StatelessWidget {
  const TranslateUpToDownAnimation({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 10 * value),
        child: child,
      ),
      child: child,
    );
  }
}

class TranslateDownToUpAnimation extends StatelessWidget {
  const TranslateDownToUpAnimation({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 10 * value),
        child: child,
      ),
      child: child,
    );
  }
}

class TranslateRightToLeftAnimation extends StatelessWidget {
  const TranslateRightToLeftAnimation({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -20, end: 0),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(-20 * value, 0),
        child: child,
      ),
      child: child,
    );
  }
}

class TranslateLeftToRightAnimation extends StatelessWidget {
  const TranslateLeftToRightAnimation({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 5, end: 0),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(-20 * value, 0),
        child: child,
      ),
      child: child,
    );
  }
}
