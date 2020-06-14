import 'package:flutter/material.dart';
import 'transition_effect.dart';

enum PageTransitionType {
  rippleRightUp,
  slideInRight,
  slideInLeft  
}

TransitionEffect transitionEffect = TransitionEffect();

Tween t2 = new Tween<Offset>(
  begin: const Offset(-1.0, 0.0),
  end: const Offset(0.0, 0.0),
);
Tween t1 = new Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: const Offset(0.0, 0.0),
);


final Map effectMap = <PageTransitionType, void>{
  PageTransitionType.rippleRightUp: TransitionEffect.createRipple(origin: 'Right'),
  PageTransitionType.slideInRight: TransitionEffect.createSlideIn(t2),
  PageTransitionType.slideInLeft: TransitionEffect.createSlideIn(t1),


};

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    Key key,
    @required this.child,
    @required this.type,
    this.curve = Curves.bounceIn,
    this.alignment,
    this.duration = const Duration(seconds: 1),
  }) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return child;
    },
    transitionDuration: duration,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child
        ) {

      return effectMap[type](curve, animation, secondaryAnimation, child);
    }
  );
}