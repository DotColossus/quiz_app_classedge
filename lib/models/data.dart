
import 'data_options.dart';
import 'metadata_data.dart';

class Data{
  String stimulusMedia;
  DataMetaData metadata;
  String stimulus;
  List<DataOptions> options;
  int marks;
  String type;

  Data({this.stimulusMedia, this.metadata,this.stimulus, this.options,this.marks, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    stimulusMedia = json['stimulus_media'];
    metadata = json['metadata'] != null ? new DataMetaData.fromJson(json['metadata']) : null;
    stimulus = json['stimulus'];
    if (json['options'] != null) {
      options = new List<DataOptions>();
      json['options'].forEach((v) { options.add(new DataOptions.fromJson(v)); });
    }
    marks = json['marks'];
    type = json['type'];
  }

}