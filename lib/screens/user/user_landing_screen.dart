import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/data/notes/notes_repo.dart';
import 'package:flutter_hackathon/screens/main_screen/main_screen.dart';

import '../../text_styles.dart';

class UserScreenArguments {
  final FirebaseUser user;

  UserScreenArguments(this.user);
}

class UserLandingScreen extends StatefulWidget {
  @override
  _UserLandingScreenState createState() => _UserLandingScreenState();
}

class _UserLandingScreenState extends State<UserLandingScreen> {
  final _repo = NotesRepo();

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserScreenArguments args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/paper/paper.png'),
              ),
            ),
            FutureBuilder<List<String>>(
              future: _repo.getListOfNotes(args.user),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data.length == 0) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No files found. Create a new one!',
                        style: kLoginTextStyle,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final file = snapshot.data[index];
                        return _buildItemDocument(args.user, file, index);
                      },
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Getting saved files from your account',
                      style: kLoginTextStyle,
                    ),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: _buildNewDocumentButton(args.user),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDocument(FirebaseUser user, String data, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/main', arguments: MainScreenArguments(user, data));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              '${index + 1}.',
              style: kLoginGoogleTextStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Text(data.substring(data.indexOf('Note-')), style: kLoginGoogleTextStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildNewDocumentButton(FirebaseUser user) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/main',
          arguments: MainScreenArguments(user, null),
        );
      },
      child: Text(
        'Add document',
        style: kOnboardingTextStyle,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
