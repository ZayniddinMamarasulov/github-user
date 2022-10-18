import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_users/models/news/news_model.dart';
import 'package:github_users/models/news_response.dart';
import 'package:github_users/screens/news_details_page.dart';
import 'package:http/http.dart' as http;

import '../models/article/article_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<News>? news;

  Future<NewsResponse?> getNews() async {
    String apiKey = "1b1677681e3f4c6980f50921844ba0e0";
    String url = "https://newsapi.org/v2/everything"
        "?q=tesla"
        "&from=2022-09-17"
        "&sortBy=publishedAt"
        "&apiKey=$apiKey";

    var response = await http.get(Uri.parse(url));

    try {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      return NewsResponse(
        statusCode: response.statusCode,
        message: "OK",
        news: News.fromJson(json),
      );
    } catch (e) {
      return NewsResponse(
          statusCode: response.statusCode,
          news: null,
          message: jsonDecode(response.body)['message'] as String);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder<NewsResponse?>(
        future: getNews(),
        builder: (BuildContext context, AsyncSnapshot<NewsResponse?> birnima) {
          if (birnima.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (birnima.connectionState == ConnectionState.done) {
            if (birnima.hasData) {
              NewsResponse? newsResponse = birnima.data;
              if (newsResponse?.news != null) {
                News? news = birnima.data?.news;
                return newsListWidget(news?.articles ?? []);
              } else {
                return Center(
                  child: Text(
                    newsResponse?.message.toString() ?? "",
                    style: TextStyle(fontSize: 24),
                  ),
                );
              }
            }
            if (birnima.hasError) {
              return Center(child: Text(birnima.error.toString()));
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget newsListWidget(List<Article> articles) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailsPage(article: articles[index]),
                ));
          },
          child: Container(
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
                Row(
                  children: [
                    Container(
                      width: 150,
                      child: Image.network(articles[index].urlToImage),
                    ),
                    SizedBox(width: 30),
                    Expanded(child: Text(articles[index].title)),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
