class MicroConcept{
  String id;
  String label;

  MicroConcept({this.id, this.label});

  MicroConcept.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

}