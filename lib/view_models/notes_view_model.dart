

import 'package:quiz_app/models/notes_model.dart';
import 'package:quiz_app/services/notes_service.dart';

import '../locator.dart';
import 'base_model.dart';

class NotesViewModel extends BaseModel {
  NotesService _NotesService = locator<NotesService>();

  List<Notes> get notesList => _NotesService.notesList;

  void addNotes(Notes obj) {
    _NotesService.addNotes(obj);
  }
}
