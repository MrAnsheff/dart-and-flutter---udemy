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
      duration: Duration(seconds: 2),
      vsync: this,
    );
    print(catController.status);

    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
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
            children: <Widget>[
              buildBox(),
              buildAnimation(),
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
          bottom: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
    );
  }
}
