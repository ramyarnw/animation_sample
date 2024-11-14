import 'package:flutter/material.dart';

class AnimationIcon extends StatefulWidget {
  const AnimationIcon({super.key});

  @override
  State<AnimationIcon> createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon> with TickerProviderStateMixin  {
  late Animation _heartbeatAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    /// initializing AnimationController
    _animationController = AnimationController(
      vsync: this,

      /// duration is the period of time the animation would last
      duration: const Duration(
        seconds: 1,
      ),
    );

    /// Tween is to configure an animation to interpolate to a different range or data type
    /// A CurvedAnimation defines progression as a non-linear curve.
    _heartbeatAnimation = Tween(begin: 180.0, end: 165.0).animate(
      CurvedAnimation(
        curve: Curves.easeOutBack,
        parent: _animationController,
      ),
    );

    /// setting listener on animation and
    /// getting its status continuously everytime when its state changes
    _animationController.addStatusListener(
          (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      },
    );

    /// forward starts the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(animation: _animationController, builder: (BuildContext c, Widget? w){
        return Center(
          child: Icon(
            Icons.favorite,
            color: Colors.red[900],
            size: _heartbeatAnimation.value,
          ),
        );
      }),
    );
  }
}
