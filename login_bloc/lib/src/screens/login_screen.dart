import 'package:flutter/material.dart';
import "../blocs/bloc.dart";
import "../blocs/provider.dart";

class LoginScreen extends StatelessWidget {
  emailField(bloc) {
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

  passwordField(bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, passwordSnapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              errorText: passwordSnapshot.error),
          onChanged: bloc.changePassword,
        );
      },
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
    final bloc = Provider.of(context);

    return Container(
        margin: EdgeInsets.all(20.0),
        child: Column(children: [
          emailField(bloc),
          passwordField(bloc),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          submitButton(),
        ]));
  }
}
