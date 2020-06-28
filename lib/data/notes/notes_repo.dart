import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

/*

Usage: 

        final repo = NotesRepo();
        repo.getListOfNotes().then((value) => value.forEach((element) {
              print(element);
            }));


*/

class NotesRepo {
  Future<void> uploadNote(String content, String filename) async {
    final file = await _writeFile(content, filename);

    StorageReference storageReference;
    if (filename == null) {
      filename = content.hashCode.toString();
    }
    storageReference = FirebaseStorage.instance.ref().child("notes/$filename");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  Future<List<String>> getListOfNotes(FirebaseUser user) async {
    final StorageReference _storageReference =
        FirebaseStorage.instance.ref().child('notes');

    return _storageReference.listAll().then((result) =>
        (result["items"] as Map<dynamic, dynamic>)
            .values
            .map((e) => (e["path"] as String))
            .toList());
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<File> _writeFile(String content, String filename) async {
    final file = await _localFile(filename);

    // Write the file.
    return file.writeAsString('$content');
  }
}
