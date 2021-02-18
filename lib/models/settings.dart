/// showQuizStarterTimer : true
/// showCountdownProgress : true

class Settings {
  bool _showQuizStarterTimer;
  bool _showCountdownProgress;

  bool get showQuizStarterTimer => _showQuizStarterTimer;
  bool get showCountdownProgress => _showCountdownProgress;

  Settings({
      bool showQuizStarterTimer, 
      bool showCountdownProgress}){
    _showQuizStarterTimer = showQuizStarterTimer;
    _showCountdownProgress = showCountdownProgress;
}

  Settings.fromJson(dynamic json) {
    _showQuizStarterTimer = json["showQuizStarterTimer"];
    _showCountdownProgress = json["showCountdownProgress"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["showQuizStarterTimer"] = _showQuizStarterTimer;
    map["showCountdownProgress"] = _showCountdownProgress;
    return map;
  }

}