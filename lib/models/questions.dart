

import 'package:quiz_app/models/solution.dart';
import 'package:quiz_app/models/solution_style.dart';

import 'data.dart';
import 'metadata.dart';

class Questions {
	String instructions;
	Metadata metadata;
	String questionID;
	Data data;
	Solution solution;
	String attachment;
	String solutionStrategies;
	SolutionStyle style;
	String type;
	String widgetType;

	Questions({this.instructions, this.metadata, this.questionID, this.data, this.solution, this.attachment, this.solutionStrategies, this.style, this.type, this.widgetType});

	Questions.fromJson(Map<String, dynamic> json) {
		instructions = json['instructions'];
		metadata = json['metadata'] != null ? new Metadata.fromJson(json['metadata']) : null;
		questionID = json['questionID'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
		solution = json['solution'] != null ? new Solution.fromJson(json['solution']) : null;
		attachment = json['attachment'];
		solutionStrategies = json['solutionStrategies'];
		style = json['style'] != null ? new SolutionStyle.fromJson(json['style']) : null;
		type = json['type'];
		widgetType = json['widget_type'];
	}


}
