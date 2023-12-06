import 'package:flutter/material.dart';

class MenuRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Curve? curve;
  final Curve? popCurve;

  MenuRoute({
    RouteSettings? settings,
    Duration? duration,
    Duration? reverseDuration,
    required this.child,
    bool? barrier,
    Color? barrierColor,
    this.curve,
    this.popCurve,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration ?? const Duration(milliseconds: 200),
          reverseTransitionDuration:
              reverseDuration ?? const Duration(milliseconds: 200),
          opaque: false,
          barrierColor:
              barrier != false ? barrierColor ?? const Color(0x80000000) : null,
          barrierDismissible: true,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(
        animation.drive(
          CurveTween(
            curve: animation.status == AnimationStatus.forward
                ? curve ?? Curves.ease
                : popCurve ?? Curves.easeOut,
          ),
        ),
      ),
      child: child,
    );
  }
}
