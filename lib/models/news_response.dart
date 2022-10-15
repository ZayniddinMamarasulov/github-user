import 'news_model.dart';

class NewsResponse {
  int? statusCode;
  String? message;
  News? news;

  NewsResponse({
    required this.statusCode,
    required this.news,
    required this.message,
  });
}
