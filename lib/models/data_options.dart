import 'data_options_feedback.dart';

class DataOptions{
  List<DataOptionsFeedback> feedback;
  int score;
  String label;
  String media;
  int value;
  int isCorrect;

  DataOptions({this.feedback, this.score, this.label, this.media, this.value, this.isCorrect});

  DataOptions.fromJson(Map<String, dynamic> json) {
    if (json['feedback'] != null) {
      feedback = new List<DataOptionsFeedback>();
      json['feedback'].forEach((v) { feedback.add(new DataOptionsFeedback.fromJson(v)); });
    }
    score = json['score'];
    label = json['label'];
    media = json['media'];
    value = json['value'];
    isCorrect = json['isCorrect'];
  }
}