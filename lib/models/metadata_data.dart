import 'distractor_rationale.dart';
import 'acknowledgement.dart';
import 'micro_concept.dart';

class DataMetaData{
  int duration;
  String difficulty;
  DistractorRationale distractorRationale;
  String bloom;
  Acknowledgement acknowledgements;
  String construct;
  bool shuffle;
  int version;
  List<MicroConcept> microConcept;

  DataMetaData({this.duration, this.difficulty, this.distractorRationale, this.bloom, this.acknowledgements, this.construct, this.shuffle, this.version, this.microConcept});

  DataMetaData.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    difficulty = json['difficulty'];
    distractorRationale = json['distractor_rationale'] != null ? new DistractorRationale.fromJson(json['distractor_rationale']) : null;
    bloom = json['bloom'];
    acknowledgements = json['acknowledgements'] != null ? new Acknowledgement.fromJson(json['acknowledgements']) : null;
    construct = json['construct'];
    shuffle = json['shuffle'];
    version = json['version'];
    if (json['microConcept'] != null) {
      microConcept = new List<MicroConcept>();
      json['microConcept'].forEach((v) { microConcept.add(new MicroConcept.fromJson(v)); });
    }
  }
}