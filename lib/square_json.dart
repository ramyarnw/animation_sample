import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SquareJson extends StatefulWidget {
  const SquareJson({super.key});

  @override
  State<SquareJson> createState() => _SquareJsonState();
}

class _SquareJsonState extends State<SquareJson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/Animation_square.json'),
      ),
    );
  }
}
