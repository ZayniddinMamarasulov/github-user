import 'article_model.dart';

class News {
  String? status;
  num? totalResults;
  List<Article>? articles;

  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json['status'] ?? "",
      totalResults: json['totalResults'] ?? 0,
      articles: (json['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList(),
    );
  }
}
