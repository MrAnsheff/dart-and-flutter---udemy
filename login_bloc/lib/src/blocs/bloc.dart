import "dart:async";
import "validators.dart";
import "package:rxdart/rxdart.dart";

class Bloc extends Object with Validators {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  Function(String) get changeEmail => _emailController.sink.add;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Function(String) get changePassword => _passwordController.sink.add;
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2<String, String, bool>(email, password,
          (emailValue, passwordValue) {
        return true;
      });

  get submit => () {
        //do something
        print("hello");
      };

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
