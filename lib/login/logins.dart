import 'package:flutter/material.dart';
import '/login/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'AccountPasswordIdentity.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
);

class _LoginPageState extends State<LoginPage>{
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
  GoogleSignInAccount? _currentUser;

  bool loggedIn = false;

  AccessToken? _accessToken;
  UserModel? currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

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
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 48.0,
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
                  AccountPasswordIdentity.IndentityPassword(
                      emailController.text, passwordController.text, context);
                },
                ),//color: Color.fromARGB(255, 132, 193, 243),
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
            _buildWidget(context),
            _buildWidgetFb(),


          ],
        ),
      ),
    );
  }

      facebookLogin() async {
        print("FaceBook");
        final result =
        await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
        if (result.status == LoginStatus.success) {
          final userData = await FacebookAuth.i.getUserData();
          print(userData);
        }
      }
  Widget _buildWidget(BuildContext context){
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
        print('xxxxxxxxxxxxxxxx');
      });
      _googleSignIn.signInSilently();
    });

    GoogleSignInAccount? user = _currentUser;
    if(user != null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
        child: Column(
          children: [
            ListTile(
              leading: GoogleUserCircleAvatar(identity: user),
              title:  Text(user.displayName ?? '', style: TextStyle(fontSize: 22),),
              subtitle: Text(user.email, style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 20,),
            const Text(
              '登入成功',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signOutGoogle,
                child: const Text('登出')
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text(
              ' ',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              '您還沒有登入',
              style: TextStyle(fontSize: 30),
            ),

            const Text(
              ' ',
              style: TextStyle(fontSize: 60),
            ),

            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: ()=>signInGoogle(context, user),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(MdiIcons.google),
                )
            ),
            const Text(
              ' ',
              style: TextStyle(fontSize: 30),
            ),

            ElevatedButton(
                onPressed: facebookLogin,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(MdiIcons.facebook),
                )
            ),


            const Text(
              ' ',
              style: TextStyle(fontSize: 30),
            ),



            SignInWithAppleButton(
              onPressed: () async {

                final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                    webAuthenticationOptions: WebAuthenticationOptions(
                        clientId: 'jp.oyster.mobile.service',
                        redirectUri: Uri.parse('https://um9kvdfvh6.execute-api.ap-northeast-1.amazonaws.com/callbacks/sign_in_with_apple'))
                );

                final Map<String, dynamic> decodedIdentityToken =
                JwtDecoder.decode(credential.identityToken ?? '');
                String id= decodedIdentityToken['sub'] as String? ?? '';
                print("id $id");




                // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              },
            ),


          ],
        ),
      );






    }
  }
  Widget _buildWidgetFb() {
    UserModel? user = currentUser;
    if (user != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: user.pictureModel!.width! / 6,
                backgroundImage: NetworkImage(user.pictureModel!.url!),
              ),
              title: Text(user.name!),
              subtitle: Text(user.email!),
            ),
            const SizedBox(height: 20,),
            const Text(
              '登入成功',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signOutFB,
                child: const Text('登出')
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text(
              ' ' ,
              style: TextStyle(fontSize: 20),
            ),

          ],
        ),
      );
    }
  }

  Future<void> signInFB() async {
    final LoginResult result = await FacebookAuth.i.login();

    if(result.status == LoginStatus.success){
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      UserModel model = UserModel.fromJson(data);

      currentUser = model;
      setState(() {

      });

    }
  }

  Future<void> signOutFB() async {
    await FacebookAuth.i.logOut();
    currentUser = null;
    _accessToken = null;
    setState(() {

    });

  }


}

void signOutGoogle(){
  _googleSignIn.disconnect();
}

Future<void> signInGoogle(BuildContext context, GoogleSignInAccount? user) async {
  try{
    await _googleSignIn.signIn();
    final result2 = await _googleSignIn.signIn();
    final String _googleUserEmail = result2?.email ?? '';
    final String _googleUserName = result2?.displayName ?? '';
    final ggAuth = await result2?.authentication;
    final idTokenSub = 'ggl_sns_$_googleUserEmail';
    final accessToken = ggAuth?.accessToken;
    print(accessToken);
    print(_googleUserEmail);
    print(_googleUserName);
    AccountPasswordIdentity.IndentityPassword(_googleUserName, _googleUserEmail , context);
  }catch (e){
    print('Error signing in $e');
  }
}

