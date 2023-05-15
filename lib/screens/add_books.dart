import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/google_books_service.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GoogleBooksService googleBooksService = GoogleBooksService();

  List<Book> listBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "home");
          },
          child: const Text(
            "Voltar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: const Text("Adicionar livro"),
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
                        title: Text(book.title),
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
                  book.title,
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
