import 'book.dart';

class PersonalBook {
  String id;
  String idGoogle;
  bool isFavorite;
  bool isRead;
  DateTime dayStarted;
  DateTime dayFinished;
  String comments;
  Book? book;

  PersonalBook({
    required this.id,
    required this.idGoogle,
    required this.isFavorite,
    required this.isRead,
    required this.dayFinished,
    required this.comments,
    required this.dayStarted,
  });

  PersonalBook.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        idGoogle = map["idGoogle"],
        isFavorite = map["isFavorite"],
        isRead = map["isRead"],
        dayFinished = DateTime.parse(map["dayFinished"]),
        dayStarted = DateTime.parse(map["dayStarted"]),
        comments = map["comments"];

  getGoogleBookById() async {}

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idGoogle": idGoogle,
      "isFavorite": isFavorite,
      "isRead": isRead,
      "dayFinished": dayFinished.toString(),
      "dayStarted": dayStarted.toString(),
      "comments": comments,
    };
  }
}
