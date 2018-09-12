import 'package:flutter/material.dart';
import "../blocs/bloc.dart";

class LoginScreen extends StatelessWidget {
  emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, emailSnapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: "you@example.com",
              labelText: "Email address",
              errorText: emailSnapshot.error),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
      ),
    );
  }

  submitButton() {
    return RaisedButton(
      child: Text("Login"),
      color: Colors.blue,
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Column(children: [
          emailField(),
          passwordField(),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          submitButton(),
        ]));
  }
}
