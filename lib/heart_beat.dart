import 'package:flutter/material.dart';

class HeartBeat extends StatefulWidget {
  const HeartBeat({super.key});

  @override
  State<HeartBeat> createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat> with TickerProviderStateMixin{
  late AnimationController motionController;
  late Animation motionAnimation;
  double size = 20;
  @override
  void initState() {
    super.initState();

    motionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        size = motionController.value * 350;
      });
    });
    // motionController.repeat();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //A bonus For you
        centerTitle: true,
        title: const Text('heartBeat'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 200,
                child: Stack(children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: size,
                      child: Image.asset('assets/images/heart.jpg'),
                    ),
                  ),
                ]),
              ),
            ),
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
