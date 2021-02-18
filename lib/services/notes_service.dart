

import 'package:quiz_app/models/notes_model.dart';

import '../locator.dart';

class NotesService {

  List<Notes> myNotes = new List();
  List<Notes> get notesList => myNotes;

  void addNotes(Notes obj) {
    myNotes.add(obj);
  }

}
