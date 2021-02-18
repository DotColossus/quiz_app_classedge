

import 'package:quiz_app/common/viewstate.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/services/questions_service.dart';

import '../locator.dart';
import 'base_model.dart';

class QuestionsViewModel extends BaseModel {
  QuestionService _QuestionService = locator<QuestionService>();


  int get questionNo => _QuestionService.questionNo;

  List<Questions> get questionOne => _QuestionService.questionOne;
  List<Questions> get questionTwo => _QuestionService.questionTwo;

  Future getQuestionOne(String response) async {
    setState(ViewState.Busy);
    await _QuestionService.parseQuestionOne(response);
    setState(ViewState.Idle);
  }

  Future getQuestionTwo(String response) async {
    setState(ViewState.Busy);
    await _QuestionService.parseQuestionTwo(response);
    setState(ViewState.Idle);
  }

  void resetQuestionNumber(){
    _QuestionService.resetQuestionNumber();
  }

  void setQuestionNumber(int val){
    _QuestionService.setQuestionNumber(val);
  }
}
