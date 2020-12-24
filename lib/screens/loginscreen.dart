import 'package:flutter/material.dart';
import 'package:flutterauthdemo/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var name, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (val) {
                name = val;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
              onChanged: (val) {
                password = val;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text("Authenticate"),
              color: Colors.blue,
              onPressed: () {
                AuthService().login(name, password).then((val) {
                  if (val.data['success']) {
                    token = val.data['token'];
                    Fluttertoast.showToast(
                      msg: "Authenticated",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                });
              },
            ),
            RaisedButton(
              child: Text("Add User"),
              color: Colors.green,
              onPressed: () {
                AuthService().addUser(name, password).then((val) {
                  Fluttertoast.showToast(
                    msg: val.data['msg'],
                    toastLength: Toast.LENGTH_SHORT,
                  );
                });
              },
            ),
            RaisedButton(
              child: Text("Get Info"),
              color: Colors.green,
              onPressed: () {
                AuthService().getinfo(token).then((val) {
                  Fluttertoast.showToast(
                    msg: val.data['msg'],
                    toastLength: Toast.LENGTH_SHORT,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
