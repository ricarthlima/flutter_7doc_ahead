class Book {
  String id;
  String title;
  String? subtitle;
  List<String> authors = [];
  String? publisher;
  String? publishedDate;
  String? description;
  String? pageCount;
  List<String> categories = [];
  String? thumbnailLink;

  Book.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["volumeInfo"]["title"],
        authors = (map["volumeInfo"]["authors"] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        subtitle = map["volumeInfo"]["subtitle"],
        thumbnailLink = map["volumeInfo"]["imageLinks"]?["thumbnail"];
}
