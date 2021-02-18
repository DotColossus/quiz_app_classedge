import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/common/constants.dart';
import 'package:quiz_app/models/topics.dart';
import 'package:quiz_app/ui/topic_lists.dart';

import 'base_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tata ClassEdge"),
        ),
        backgroundColor: themeColor,
        body: SingleChildScrollView(
          child: Container(
            //padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    ORGANIZATION_NAME,
                    textScaleFactor: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    child: Center(
                      child: FutureBuilder(
                          future: DefaultAssetBundle.of(context)
                              .loadString('assets/topics.json'),
                          builder: (context, snapshot) {
                            List<Topic> topicsObj =
                            parseTopics(snapshot.data.toString());
                            return topicsObj.isNotEmpty
                                ? new TopicsList(topics: topicsObj)
                                : new Center(
                                child: new CircularProgressIndicator());
                          }),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Topic> parseTopics(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Topic>((json) => new Topic.fromJson(json)).toList();
  }
}
