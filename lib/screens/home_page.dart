import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_users/models/quote.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<QuoteModel?> getData() async {
    String url = "https://quotable.io/random";

    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return QuoteModel.fromJson(json);
    }

    return null;
  }

  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: FutureBuilder<QuoteModel?>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<QuoteModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            QuoteModel? quoteModel = snapshot.data;
            return Container(
              width: double.infinity,
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    quoteModel?.content ?? "",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    quoteModel?.author ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                      value: isOn,
                      onChanged: (val) {
                        setState(() {
                          isOn = val;
                        });
                      })
                ],
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
