import 'package:flutter/material.dart';
import 'package:flutter_hackathon/text_styles.dart';

class LoginScreen extends StatelessWidget {
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

  Widget _skipWidget(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 2.0),
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.grey)),
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
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/login/google_logo.png"), height: 25.0),
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
