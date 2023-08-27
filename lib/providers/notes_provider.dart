import 'package:flutter/widgets.dart';

import '../models/note_model.dart';

class NotesProvider extends ChangeNotifier{
    List<NoteModel> _notes = [
    NoteModel(title: 'Note 1', content: 'Content 1'),
    NoteModel(title: 'Note 2', content: 'Content 2'),
    NoteModel(title: 'Note 3', content: 'Content 3'),
    NoteModel(title: 'Note 4', content: 'Content 4'),
    NoteModel(title: 'Note 5', content: 'Content 5'),
    ];
    void addNote(NoteModel note){
      _notes.add(note);
      notifyListeners();
    }
    List<NoteModel> get notes => _notes;
    void deleteNotes(int index){
      _notes.removeAt(index);
      notifyListeners();
    }
    void updateNote(int index,NoteModel note){
      _notes[index] = note;
      notifyListeners();
    }
    List<NoteModel> searchNotes(String query){
      return _notes.where((element) =>
          element.title.toLowerCase().contains(query.toLowerCase())||
          element.content.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

}