import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ses5/screens/notes.dart';
import 'providers/notes_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => NotesProvider()
          ),


        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: NotesScreen(),

        )
    );
  }
}
