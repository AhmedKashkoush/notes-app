import 'package:flutter/material.dart';

class FadePageTransition extends PageRouteBuilder {
  final Widget page;
  FadePageTransition({
    required this.page,
  }) : super(
          transitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (context, animation, _, child) {
            return FadeTransition(
              child: child,
              opacity: animation,
            );
          },
          pageBuilder: (context, animation, _) {
            return page;
          },
        );
}
