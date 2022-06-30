import 'package:flutter/material.dart';

import 'AccountPasswordIdentity.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    /*
  final btn6 = Expanded(
    child: FloatingActionButton(
      onPressed: () => null,
      child: Container(
        child: Icon(Icons.phone_android),
      ),
      elevation: 5,
      shape: CircleBorder(),
    ),
  );
  final btn7 = Expanded(
      child: FloatingActionButton(
    child: Icon(Icons.mail),
    elevation: 5,
    shape: CircleBorder(),
    onPressed: () => null,
  ));
  final btn8 = Expanded(
      child: FloatingActionButton(
    child: Icon(Icons.phone_android),
    elevation: 5,
    shape: CircleBorder(),
    onPressed: () => null,
  ));
*/
      return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Name *",
                    hintText: "Your account username",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: TextFormField(
                  controller:passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    labelText: "Password *",
                    hintText: "Your account password or ...",
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'Forgot Password?',
                    ),
                    height: 42.0,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48.0,
                height: 48.0,
                child: ElevatedButton(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  onPressed: () {
                    print("hello world ");
                    AccountPasswordIdentity.IndentityPassword(emailController.text , passwordController.text , context);
                  },
                  //color: Color.fromARGB(255, 132, 193, 243),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      "Or Sign up With",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    height: 62.0,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              /*
            Row(
              children: <Widget>[
                Container(
                  child: btn6,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: btn7,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: btn8,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            */
            ],
          ),
        ),
      );
      // ignore: dead_code

  }

}
