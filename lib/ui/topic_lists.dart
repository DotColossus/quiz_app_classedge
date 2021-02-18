
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/common/hexcolor.dart';
import 'package:quiz_app/models/topics.dart';


class TopicsList extends StatelessWidget {
  final List<Topic> topics;
  TopicsList({Key key, this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: topics == null ? 0 : topics.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'login');
            },
            child: Card(
              color: HexColor(topics[index].topicBackgroundColor),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.all(10),
              child: new Container(
                height: 150,
                child: new Center(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          topics[index].topicName,
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ],
                    )),
                padding: const EdgeInsets.all(15.0),
              ),
            ),
          );
        });
  }
}