import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_7doc_ahead/models/personal_book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Pequeno Grimório"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "add_book");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              SharedPreferences sharedPreferences = snapshot.data!;

              List<String>? listStringBooks =
                  sharedPreferences.getStringList("BOOKS");

              if (listStringBooks != null && listStringBooks.isNotEmpty) {
                return Wrap(
                  children: List.generate(
                    listStringBooks.length,
                    (index) {
                      PersonalBook personalBook = PersonalBook.fromMap(
                          json.decode(listStringBooks[index]));

                      return FutureBuilder(
                        future: personalBook.getGoogleBookById(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (personalBook.book!.thumbnailLink != null)
                                    ? Image.network(
                                        personalBook.book!.thumbnailLink!,
                                        height: 200,
                                      )
                                    : Container(
                                        height: 200,
                                        color: Colors.purple,
                                        child: const Icon(Icons.book),
                                      ),
                                Text(
                                  personalBook.book!.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.purple[200],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                //Author
                                Text(
                                  personalBook.book!.authors[0],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[400],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text("Ainda nenhum livro, vamos adicionar?"),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
