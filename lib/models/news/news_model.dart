import '../article/article_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  @JsonKey(name: 'status', defaultValue: '')
  String status;

  @JsonKey(name: 'totalResults', defaultValue: 0)
  num totalResults;

  @JsonKey(name: 'articles', defaultValue: [])
  List<Article> articles;

  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
