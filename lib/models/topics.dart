/// topic : [{"topicId":1,"topicName":"Mathematics","topicBackgroundColor":"Red"},{"topicId":2,"topicName":"Science","topicBackgroundColor":"Red"},{"topicId":3,"topicName":"English","topicBackgroundColor":"Red"},{"topicId":4,"topicName":"Geography","topicBackgroundColor":"Red"},{"topicId":5,"topicName":"History","topicBackgroundColor":"Red"}]

class Topics {
  List<Topic> _topic;

  List<Topic> get topic => _topic;

  Topics({
      List<Topic> topic}){
    _topic = topic;
}

  Topics.fromJson(dynamic json) {
    if (json["topic"] != null) {
      _topic = [];
      json["topic"].forEach((v) {
        _topic.add(Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_topic != null) {
      map["topic"] = _topic.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// topicId : 1
/// topicName : "Mathematics"
/// topicBackgroundColor : "Red"

class Topic {
  int _topicId;
  String _topicName;
  String _topicBackgroundColor;

  int get topicId => _topicId;
  String get topicName => _topicName;
  String get topicBackgroundColor => _topicBackgroundColor;

  Topic({
      int topicId, 
      String topicName, 
      String topicBackgroundColor}){
    _topicId = topicId;
    _topicName = topicName;
    _topicBackgroundColor = topicBackgroundColor;
}

  Topic.fromJson(dynamic json) {
    _topicId = json["topicId"];
    _topicName = json["topicName"];
    _topicBackgroundColor = json["topicBackgroundColor"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["topicId"] = _topicId;
    map["topicName"] = _topicName;
    map["topicBackgroundColor"] = _topicBackgroundColor;
    return map;
  }

}