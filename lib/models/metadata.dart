class Metadata{
  String templateReference;
  String name;

  Metadata({this.templateReference, this.name});

  Metadata.fromJson(Map<String, dynamic> json) {
    templateReference = json['template_reference'];
    name = json['name'];
  }

}