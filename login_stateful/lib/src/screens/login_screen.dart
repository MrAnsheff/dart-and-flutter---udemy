import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

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
          labelText: "Email address", hintText: "you@example.com"),
    );
  }

  _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
      ),
    );
  }

  _submitButton() {
    return RaisedButton(
      child: Text("Submit!"),
      color: Colors.blue,
      onPressed: () {},
    );
  }
}
