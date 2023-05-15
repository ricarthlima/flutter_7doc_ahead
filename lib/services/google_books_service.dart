import 'dart:convert';
import 'dart:math';

import 'package:flutter_7doc_ahead/models/book.dart';
import 'package:http/http.dart' as http;

class GoogleBooksService {
  static const String baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<List<Book>> searchBooks(String name) async {
    http.Response httpResponse = await http.get(Uri.parse("$baseUrl/?q=$name"));

    Map<String, dynamic> response = json.decode(httpResponse.body);
    var listResponse = response["items"];

    List<Book> listResult = [];
    for (int i = 0; i < min(listResponse.length, 10); i++) {
      listResult.add(Book.fromMap(listResponse[i]));
    }

    return listResult;
  }
}
