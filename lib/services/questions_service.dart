import 'dart:convert';


import 'package:quiz_app/models/questions.dart';

import '../locator.dart';

class QuestionService {

  List<Questions> _Question1;
  List<Questions> get questionOne => _Question1;

  List<Questions> _Question2;
  List<Questions> get questionTwo => _Question2;

  int _QuestionNo;
  int get questionNo => _QuestionNo;


  List<Questions> parseQuestionOne(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    _Question1 =  parsed.map<Questions>((json) => new Questions.fromJson(json)).toList();
    _QuestionNo =1;
  }

  List<Questions> parseQuestionTwo(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    _Question2 =  parsed.map<Questions>((json) => new Questions.fromJson(json)).toList();
    _QuestionNo = 2;
  }

  void resetQuestionNumber(){
    _QuestionNo = 0;
  }

  void setQuestionNumber(int val){
    _QuestionNo = val;
  }

}
