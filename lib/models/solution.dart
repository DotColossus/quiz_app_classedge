class Solution{
  String answer;
  bool stepNav;
  String type;

  Solution({this.answer, this.stepNav, this.type});

  Solution.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    stepNav = json['step_nav'];
    type = json['type'];
  }


}