import 'package:github_users/models/source/source_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
  @JsonKey(name: 'source', defaultValue: '')
  Source source;

  @JsonKey(name: 'author', defaultValue: '')
  String author;

  @JsonKey(name: 'title', defaultValue: '')
  String title;

  @JsonKey(name: 'description', defaultValue: '')
  String description;

  @JsonKey(name: 'url', defaultValue: '')
  String url;

  @JsonKey(name: 'urlToImage', defaultValue: '')
  String urlToImage;

  @JsonKey(name: 'publishedAt', defaultValue: '')
  String publishedAt;

  @JsonKey(name: 'content', defaultValue: '')
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
