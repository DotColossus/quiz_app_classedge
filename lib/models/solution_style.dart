class SolutionStyle{
  QStyle qStyle;
  UserInteraction userInteraction;

  SolutionStyle({this.qStyle, this.userInteraction});

  SolutionStyle.fromJson(Map<String, dynamic> json) {
    qStyle = json['qStyle'] != null ? new QStyle.fromJson(json['qStyle']) : null;
    userInteraction = json['userInteraction'] != null ? new UserInteraction.fromJson(json['userInteraction']) : null;
  }

}

class QStyle {
  String bg;

  QStyle({this.bg});

  QStyle.fromJson(Map<String, dynamic> json) {
    bg = json['bg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bg'] = this.bg;
    return data;
  }
}

class UserInteraction {
  String stylePrint;
  String stylePreview;
  String styleReview;
  String styleAttempt;

  UserInteraction({this.stylePrint, this.stylePreview, this.styleReview, this.styleAttempt});

  UserInteraction.fromJson(Map<String, dynamic> json) {
    stylePrint = json['stylePrint'];
    stylePreview = json['stylePreview'];
    styleReview = json['styleReview'];
    styleAttempt = json['styleAttempt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stylePrint'] = this.stylePrint;
    data['stylePreview'] = this.stylePreview;
    data['styleReview'] = this.styleReview;
    data['styleAttempt'] = this.styleAttempt;
    return data;
  }
}