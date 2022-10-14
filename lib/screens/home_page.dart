import 'dart:convert';
import 'dart:math';

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
  Future<QuoteModel?>? getResult;

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
  void initState() {
    super.initState();
    update();
  }

  Future<void> update() async {
    getResult = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<QuoteModel?>(
          future: getResult,
          builder: (BuildContext context, AsyncSnapshot<QuoteModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              QuoteModel? quoteModel = snapshot.data;
              // return Container();
              return buildBody(quoteModel);
            }
            return Container();
          },
        ),
      ),
    );
  }

  PageController pageController = PageController();

  Widget buildBody(QuoteModel? quoteModel) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            update();
          });
        },
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.97,
                  child: Image.network(
                    "https://picsum.photos/400/600?blur/${Random().nextInt(50) + 1}",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.97,
                  color: Colors.black.withOpacity(0.4),
                  width: double.infinity,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        quoteModel?.content ?? "No",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      quoteModel?.author ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
