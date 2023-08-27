import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ses5/models/note_model.dart';
import '../widgets/search_notes_delegate.dart';
import '../providers/notes_provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NotesProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          String title="";
          String content="";
          showDialog(context: context,
              builder: (context)=>AlertDialog(
                title: Text("Warning"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value){
                        title = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      onChanged: (value){
                        content = value;
                      },
                      decoration: InputDecoration(
                        labelText: "content",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Add"),
                    onPressed: (){
                      provider.addNote(
                          NoteModel(title: title, content: content)
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
          );

        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: (){
               showSearch(context: context, delegate: SearchNotesDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(provider.notes[index]),
                onDismissed: (direction){
                  provider.deleteNotes(index);
                },
                child: ListTile(
                  onTap: (){
                    String updatedTitle=provider.notes[index].title;
                     String updatedContent=provider.notes[index].content;
                    showDialog(context: context,
                        builder: (context)=>AlertDialog(
                          title: Text("Warning"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(

                                controller: TextEditingController(text: provider.notes[index].title),
                                onChanged: (value){
                                  updatedTitle = value;
                                },
                                decoration: InputDecoration(

                                  labelText: "Enter title",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextField(
                                controller: TextEditingController(text: provider.notes[index].content),

                                onChanged: (value){
                                  updatedContent = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "content",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text("Save"),
                              onPressed: (){
                                provider.updateNote(index, NoteModel(title: updatedTitle
                                    , content: updatedContent));
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                    );
                  },
                  title: Text(provider.notes[index].title),
                subtitle: Text(provider.notes[index].content),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
