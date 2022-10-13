class QuoteModel {
  String id;
  String content;
  String author;

  QuoteModel({
    required this.id,
    required this.content,
    required this.author,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> jsonData) {
    String id = jsonData['_id'] as String;
    String content = jsonData['content'] as String;
    String author = jsonData['author'] as String;
    return QuoteModel(
      id: id,
      content: content,
      author: author,
    );
  }
}
