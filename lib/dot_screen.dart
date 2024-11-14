import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class DotScreen extends StatefulWidget {
  const DotScreen({super.key});

  @override
  State<DotScreen> createState() => _DotScreenState();
}

class _DotScreenState extends State<DotScreen> {
  final double _circleSize = 100;
  Offset _circlePosition=const Offset(0, 0);
  double _slope = 0;
  double _xDistance = 0;
  int _tapCount = 0;
  final double _secondCircleSize = 150;
   Offset _secondCirclePosition= const Offset(50, 50);

  void moveRight(double slope, int i) {
    Timer.periodic(const Duration(milliseconds: 8), (timer) {
//       if (_tapCount != i) {
//         timer.cancel();
// //Stop moving in this direction when the screen is tapped again
//       }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition.dx + _xDistance,
            _circlePosition.dy - slope * _xDistance);
      });

//if the ball bounces off the top or bottom

      if (_circlePosition.dy < 0 ||
          _circlePosition.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        moveRight(-slope, i);
      }
//if the ball bounces off the right
      if (_circlePosition.dx >
          MediaQuery.of(context).size.width - _circleSize) {
        timer.cancel();
        moveLeft(-slope, i);
      }
    });
  }

  void moveLeft(double slope, int i) {
    Timer.periodic(const Duration(milliseconds: 8), (timer) {
//       if (_tapCount != i) {
//         timer.cancel();
// //Stop moving in this direction when the screen is tapped again
//
//       }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _circlePosition = Offset(_circlePosition.dx - _xDistance,
            _circlePosition.dy + slope * _xDistance);
      });

//if the ball bounces off the top or bottom
      if (_circlePosition.dy < 0 ||
          _circlePosition.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        moveLeft(-slope, i);
      }
//if the ball bounces off the left
      if (_circlePosition.dx < 0) {
        timer.cancel();
        moveRight(-slope, i);
      }
    });
  }
  void moveRightSecond(double slope, int i) {
    Timer.periodic(const Duration(milliseconds: 8), (timer) {
//       if (_tapCount != i) {
//         timer.cancel();
// //Stop moving in this direction when the screen is tapped again
//       }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _secondCirclePosition = Offset(_secondCirclePosition.dx + _xDistance,
            _secondCirclePosition.dy - slope * _xDistance);
      });

//if the ball bounces off the top or bottom

      if (_secondCirclePosition.dy < 0 ||
          _secondCirclePosition.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        moveRight(-slope, i);
      }
//if the ball bounces off the right
      if (_secondCirclePosition.dx >
          MediaQuery.of(context).size.width - _circleSize) {
        timer.cancel();
        moveLeft(-slope, i);
      }
    });
  }

  void moveLeftSecond(double slope, int i) {
    Timer.periodic(const Duration(milliseconds: 8), (timer) {
//       if (_tapCount != i) {
//         timer.cancel();
// //Stop moving in this direction when the screen is tapped again
//
//       }
      _xDistance = sqrt(1 / (1 + pow(slope, 2)));
      setState(() {
        _secondCirclePosition = Offset(_secondCirclePosition.dx - _xDistance,
            _secondCirclePosition.dy + slope * _xDistance);
      });

//if the ball bounces off the top or bottom
      if (_secondCirclePosition.dy < 0 ||
          _secondCirclePosition.dy >
              MediaQuery.of(context).size.height - _circleSize) {
        timer.cancel();
        moveLeft(-slope, i);
      }
//if the ball bounces off the left
      if (_secondCirclePosition.dx < 0) {
        timer.cancel();
       moveRight(-slope, i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          PositionedTapDetector2(
            onTap: (position) {
              _tapCount++;
              _slope = (-position.global.dy + _circlePosition.dy) /
                  (position.global.dx - _circlePosition.dx);
              if (position.global.dx < _circlePosition.dx) {
                moveLeft(_slope, _tapCount);
              }
              if (position.global.dx > _circlePosition.dx) {
                moveRight(_slope, _tapCount);
              }
            },
            onLongPress: (position) {
              _tapCount++; //stop moving
              setState(() {
                _circlePosition = Offset(
                    (MediaQuery.of(context).size.width - _circleSize) / 2,
                    (MediaQuery.of(context).size.height - _circleSize) / 2);
                //reset back to middle
              });
            },
          ),
          Positioned(
            left: _circlePosition.dx,
            top: _circlePosition.dy,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              height: _circleSize,
              width: _circleSize,
            ),
          ),
          PositionedTapDetector2(
            onTap: (position) {
              _tapCount++;
              _slope = (-position.global.dy + _secondCirclePosition.dy) /
                  (position.global.dx - _secondCirclePosition.dx);
              if (position.global.dx < _secondCirclePosition.dx) {
                moveLeftSecond(_slope, _tapCount);
              }
              if (position.global.dx > _secondCirclePosition.dx) {
                moveRightSecond(_slope, _tapCount);
              }
            },
            onLongPress: (position) {
              _tapCount++; //stop moving
              setState(() {
                _secondCirclePosition = Offset(
                    (MediaQuery.of(context).size.width - _circleSize) / 2,
                    (MediaQuery.of(context).size.height - _circleSize) / 2);
                //reset back to middle
              });
            },
          ),
          Positioned(
            left: _secondCirclePosition.dx,
            top: _secondCirclePosition.dy,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              height: _secondCircleSize,
              width: _secondCircleSize,
            ),
          ),
        ],
      ),
    );
  }
}
