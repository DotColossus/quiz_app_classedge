class DistractorRationale{
  String label;
  String audio;

  DistractorRationale({this.label, this.audio});

  DistractorRationale.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    audio = json['audio'];
  }

}