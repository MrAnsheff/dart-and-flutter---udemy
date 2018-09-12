import "dart:async";
import "validators.dart";
import "package:rxdart/rxdart.dart";

class Bloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  Function(String) get changeEmail => _emailController.sink.add;
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  final _passwordController = BehaviorSubject<String>();
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
        print(
            "hello? ${_emailController.value} - ${_passwordController.value}");
      };

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
