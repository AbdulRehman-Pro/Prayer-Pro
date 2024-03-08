import 'package:flutter/material.dart';

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Future<void> navigateTo(
    BuildContext context,
    Widget nextScreen, {
      bool fadeAnimate = true,
      int milliseconds = 600,
      ValueChanged<dynamic>? onReturnResult,
    }) async {
  final result = await Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: Duration(milliseconds: milliseconds),
    reverseTransitionDuration: Duration(milliseconds: milliseconds),
    pageBuilder: (_, __, ___) => nextScreen,
    transitionsBuilder: (fadeAnimate == true)
        ? (_, Animation<double> animation, __, Widget child) {
      const begin = 0.0;
      const end = 1.0;
      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      // You can choose a different transition, for example, fade:
      return FadeTransition(
        opacity: tween.animate(curvedAnimation),
        child: child,
      );
    }
        : (_, __, ___, ____) {
      return const SizedBox.shrink();
    },
  ));

  onReturnResult!(result);
}

void navigateReplaceTo(BuildContext context, Widget nextScreen,
    {bool fadeAnimate = true, int milliseconds = 600}) {
  Navigator.of(context).pushReplacement(PageRouteBuilder(
    transitionDuration: Duration(milliseconds: milliseconds),
    reverseTransitionDuration: Duration(milliseconds: milliseconds),
    pageBuilder: (_, __, ___) => nextScreen,
    transitionsBuilder: (fadeAnimate == true)
        ? (_, Animation<double> animation, __, Widget child) {
      const begin = 0.0;
      const end = 1.0;
      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      // You can choose a different transition, for example, fade:
      return FadeTransition(
        opacity: tween.animate(curvedAnimation),
        child: child,
      );
    }
        : (_, __, ___, ____) {
      return const SizedBox.shrink();
    },
  ));
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
