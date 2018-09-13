import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    catAnimation = Tween(begin: -15.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  void opTap() {
    if (catController.status == AnimationStatus.completed)
      catController.reverse();
    else if (catController.status == AnimationStatus.dismissed)
      catController.forward();
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
}
