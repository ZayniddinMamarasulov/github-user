import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_users/models/news_model.dart';
import 'package:github_users/models/news_response.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<News>? news;

  Future<News?> getNews() async {
    String apiKey = "1b1677681e3f4c6980f50921844ba0e0";
    String url = "https://newsapi.org/v2/everything"
        "?q=tesla"
        "&from=2022-09-15"
        "&sortBy=publishedAt"
        "&apiKey=$apiKey";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      return News.fromJson(json);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<News?>(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot<News?> birnima) {
          if (birnima.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (birnima.connectionState == ConnectionState.done) {
            if (birnima.hasData) {
              News? news = birnima.data;
              return newsListWidget(news?.articles);
            }
            if (birnima.hasError) {
              return Center(child: Text(birnima.error.toString()));
            }
          }
          return Container(
            child: Center(
              child: Text(
                "Nimdir xatolik bor",
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget newsListWidget(List<Article>? articles) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: articles?.length ?? 0,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.4),
                  blurRadius: 4,
                )
              ]),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Text((index + 1).toString()),
              Text(articles?[index].content ?? "No data"),
            ],
          ),
        );
      },
    );
  }
}
