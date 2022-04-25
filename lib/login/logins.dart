import 'package:flutter/material.dart';

import 'AccountPasswordIdentity.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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
  @override
  Widget build(BuildContext context) {
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


/*

class Myhome extends StatefulWidget{
  @override
  _Myhome createState() => _Myhome();
}

class _Myhome extends State<Myhome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Map(),
          appBar: Tabbar_interface(pageType: 0),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.account_box,
                            size: 60,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Email_Adress",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                ListTile(
                  title: const Text(
                    '導航',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.airplanemode_active_outlined, size: 30),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    '儲存地點',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.archive, size: 30),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    '登出',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.wrap_text, size: 30),
                  onTap: () async {
                    String email = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    //update(email);
                  },
                ),
                ListTile(
                  title: const Text(
                    '設定',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text(
                    '分析',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  leading: Icon(Icons.wrap_text, size: 30),
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => analysis_page()));

                    // Update the state of the app
                    // ...
                    // Then close the drawer
                  },
                ),
              ],
            ),
          ),
        ));
  }


  void update(String e){
    setState((){
      email = e ;
    });
  }
}
 */