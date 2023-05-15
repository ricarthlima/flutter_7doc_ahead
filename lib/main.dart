import 'package:flutter/material.dart';
import 'package:flutter_7doc_ahead/screens/add_books.dart';
import 'package:flutter_7doc_ahead/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Pequeno Grimório',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
        "add_book": (context) => const AddBookScreen(),
      },
    );
  }
}
