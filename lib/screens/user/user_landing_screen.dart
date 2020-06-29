import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/data/notes/notes_repo.dart';
import 'package:flutter_hackathon/screens/main_screen/main_screen.dart';

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/main',
                  arguments: MainScreenArguments(args.user, null),
                );
              },
              child: Text(
                'New file >>',
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: FutureBuilder<List<String>>(
                future: _repo.getListOfNotes(args.user),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final file = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/main', arguments: MainScreenArguments(args.user, file));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(file),
                          ),
                        );
                      },
                    );
                  }

                  return Flexible(child: Text('No files. Create a new one.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
