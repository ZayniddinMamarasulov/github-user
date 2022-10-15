import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_users/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GithubUsersPage extends StatefulWidget {
  const GithubUsersPage({Key? key}) : super(key: key);

  @override
  State<GithubUsersPage> createState() => _GithubUsersPageState();
}

class _GithubUsersPageState extends State<GithubUsersPage> {
  Future<List<User>?>? getResult;

  Future<List<User>> getData() async {
    String url = "https://api.github.com/users";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body) as List;
      List<User> users = json.map((e) => User.fromJson(e)).toList();
      return users;
    }

    return List.empty();
  }

  @override
  void initState() {
    super.initState();

    getResult = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<User>?>(
          future: getResult,
          builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
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
              List<User?>? users = snapshot.data;

              return ListView.builder(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            users?[index]?.login ?? "NO",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            (users?[index]?.id ?? 0).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
