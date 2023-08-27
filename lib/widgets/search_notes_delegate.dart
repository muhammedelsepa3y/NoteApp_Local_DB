import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ses5/models/note_model.dart';

import '../providers/notes_provider.dart';

class SearchNotesDelegate extends SearchDelegate {
  Widget buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        query = value;
      },
      decoration: InputDecoration(
        labelText: "Search",
        border: OutlineInputBorder(),
      ),);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      query = "";
    }, icon: Icon(Icons.clear))];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      List<NoteModel> notes = Provider.of<NotesProvider>(context).searchNotes(query);
      return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].content),
            );
          });


  }
}
