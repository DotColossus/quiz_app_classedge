class DataOptionsFeedback{
  String text;
  String media;

  DataOptionsFeedback({this.text, this.media});

  DataOptionsFeedback.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    media = json['media'];
  }
}