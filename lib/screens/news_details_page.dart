import 'package:flutter/material.dart';
import 'package:github_users/models/article/article_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsPage extends StatelessWidget {
  Article? article;

  NewsDetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article?.title ?? "News"),
      ),
      body: WebView(
        initialUrl: article?.url ?? "",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
