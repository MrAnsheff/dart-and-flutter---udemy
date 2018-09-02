import 'package:flutter/material.dart';
import "../mixins/validation_mixin.dart";

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  _emailField(),
                  _passwordField(),
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                  ),
                  _submitButton(),
                ],
              ))),
    );
  }

  Widget _emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email address",
        hintText: "you@example.com",
      ),
      validator: validateEmail,
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
      ),
      validator: validatePassword,
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  _submitButton() {
    return RaisedButton(
      child: Text("Submit!"),
      color: Colors.blue,
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print("use email ($_email) and password ($_password)");
        }
      },
    );
  }
}
