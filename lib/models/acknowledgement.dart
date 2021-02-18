class Acknowledgement{
  String label;
  String audio;

  Acknowledgement({this.label, this.audio});

  Acknowledgement.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    audio = json['audio'];
  }
}