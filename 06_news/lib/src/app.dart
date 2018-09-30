import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'resources/injector.dart' as injector;
import 'screens/routes.dart' as routes;

class App extends StatelessWidget {
  final router = Router();
  App() {
    routes.setup(router);
    injector.setup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News!",
      onGenerateRoute: router.generator,
    );
  }
}
