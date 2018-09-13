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

    catAnimation = Tween(begin: 0.0, end: 250.0).animate(
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
        child: Stack(
          children: <Widget>[
            buildAnimation(),
            buildBox(),
          ],
        ),
        onTap: opTap,
      ),
    );
  }

  buildBox() {
    return Center(
      child: Container(
        height: 200.0,
        width: 200.0,
        color: Colors.brown,
      ),
    );
  }

  buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (BuildContext context, Widget child) {
        return Container(
            child: child, margin: EdgeInsets.only(top: catAnimation.value));
      },
    );
  }
}
