import 'dart:async';

import 'package:covid_19_app/screens/state_list.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animatedCont =
      AnimationController(duration: const Duration(seconds: 10), vsync: this)
        ..repeat();
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StatesList())));
  }

  @override
  void dispose() {
    super.dispose();
    animatedCont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animatedCont,
              builder: ((BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: animatedCont.value * 2.0 * math.pi,
                  child: child,
                );
              }),
              child: Container(
                decoration: const BoxDecoration(),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Center(
                    child: Image(image: AssetImage("assest/images/covid.png"))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            const Center(
                child: Text(
              "Covid-19\n Tracker App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ))
          ]),
    );
  }
}
