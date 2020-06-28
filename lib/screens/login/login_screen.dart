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
    FirebaseAuth.instance.currentUser().then((firebaseUser){
      if(firebaseUser != null) {
        Navigator.pushNamed(
            context, '/user', arguments: UserScreenArguments(firebaseUser)
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/login/logo.png"),
                      height: 200.0,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Login to save your work on the cloud and access it on different devices.',
                      overflow: TextOverflow.visible,
                      style: kLoginTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    _googleSignInWidget(context),
                    SizedBox(
                      height: 20,
                    ),
                    _skipWidget(context),
                  ],
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
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    return user;
  }

  Widget _skipWidget(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.grey)),
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
      color: Colors.white,
      splashColor: Colors.grey,
      onPressed: () {
        _signInWithGoogle()
            .then((FirebaseUser user) => Navigator.pushReplacementNamed(
                context, '/user',
                arguments: UserScreenArguments(user)
        ))
            .catchError((e) => print(e));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/login/google_logo.png"),
                height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
