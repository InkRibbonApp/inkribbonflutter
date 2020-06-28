import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/user/user_landing_screen.dart';
import 'package:flutter_hackathon/text_styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((firebaseUser) {
      if (firebaseUser != null) {
        Navigator.pushNamed(context, '/user', arguments: UserScreenArguments(firebaseUser));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image(fit: BoxFit.fill, image: AssetImage('assets/paper/paper.png'))),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image(
                    image: AssetImage("assets/login/inkribbon-logo.png"),
                    height: 160.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        'Login to save your work on the cloud and access it on different devices',
                        overflow: TextOverflow.visible,
                        style: kLoginGoogleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      _googleSignInWidget(context),
                      _skipWidget(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    return user;
  }

  Widget _skipWidget(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
      color: Colors.transparent,
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/main');
      },
      child: Text(
        'Skip >>',
        style: kLoginTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _googleSignInWidget(BuildContext context) {
    return FlatButton(
      onPressed: () {
        _signInWithGoogle()
            .then((FirebaseUser user) =>
                Navigator.pushReplacementNamed(context, '/user', arguments: UserScreenArguments(user)))
            .catchError((e) => print(e));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/login/google_logo.png"), height: 25.0),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: kLoginTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
