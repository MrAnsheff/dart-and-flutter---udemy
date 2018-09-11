import "dart:async";

class Bloc {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Stream<String> get email => _emailController.stream;

  Function(String) get changePassword => _passwordController.sink.add;
  Stream<String> get password => _passwordController.stream;
}
