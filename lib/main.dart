import 'package:flutter/material.dart';
import 'package:flutter_7doc_ahead/google_books_service.dart';

import 'book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.purple,
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GoogleBooksService googleBooksService = GoogleBooksService();

  List<Book> listBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu pequeno grimório"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _searchController,
              decoration:
                  const InputDecoration(label: Text("Digite o nome do livro")),
            ),
            ElevatedButton(
              onPressed: () {
                searchBooks();
              },
              child: const Text("Buscar"),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    listBooks.length,
                    (index) {
                      Book book = listBooks[index];
                      return ListTile(
                        onTap: () {
                          showBookDialog(book, context);
                        },
                        leading: (book.thumbnailLink != null)
                            ? Image.network(book.thumbnailLink!)
                            : const Icon(Icons.book),
                        title: Text(book.title!),
                        subtitle: Text(book.authors.first),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  searchBooks() async {
    List<Book> result =
        await googleBooksService.searchBooks(_searchController.text);
    setState(() {
      listBooks = result;
    });
  }

  showBookDialog(Book book, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                (book.thumbnailLink != null)
                    ? Image.network(book.thumbnailLink!)
                    : const Icon(Icons.book),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  book.title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(book.authors[0]),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Adicionar aos meus livros lidos"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
