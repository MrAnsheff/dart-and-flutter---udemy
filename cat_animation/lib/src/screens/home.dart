import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import "dart:math";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    catAnimation = Tween(
      begin: -15.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    boxController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.67,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );

    boxAnimation.addStatusListener((newStatus) {
      if (newStatus == AnimationStatus.completed) {
        boxController.reverse();
      } else if (newStatus == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();
  }

  void opTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: opTap,
      ),
    );
  }

  buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  buildLeftFlap() {
    return Positioned(
      left: 8.0,
      top: 8.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }

  buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (BuildContext context, Widget child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
    );
  }

  buildRightFlap() {
    return Positioned(
      right: 8.0,
      top: 8.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}
