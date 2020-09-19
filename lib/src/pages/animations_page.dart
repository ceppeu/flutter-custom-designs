import 'dart:math' as Math;

import 'package:flutter/material.dart';

class AnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> opacityOut;
  Animation<double> moveRight;
  Animation<double> resize;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    opacity = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.25, curve: Curves.easeOut)));

    opacityOut = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.75, 1.0, curve: Curves.easeOut)));

    moveRight = Tween(begin: 0.0, end: 200.0).animate(animationController);

    resize = Tween(begin: 0.0, end: 2.0).animate(animationController);

    animationController.addListener(() {
      print('Status: ${animationController.status}');
      if (animationController.status == AnimationStatus.completed) {
        // animationController.reverse();
        // animationController.repeat();
        animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      child: _Rectangulo(),
      builder: (BuildContext context, child) {
        return Transform.scale(
          scale: resize.value,
          child: Transform.translate(
              offset: Offset(moveRight.value, 0.0),
              child: Transform.rotate(
                angle: rotation.value,
                child: Opacity(
                  opacity: opacity.value - opacityOut.value,
                  child: child,
                ),
              )),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(color: Colors.blue));
  }
}
