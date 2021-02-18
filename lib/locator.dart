
import 'package:get_it/get_it.dart';
import 'package:quiz_app/services/notes_service.dart';
import 'package:quiz_app/services/questions_service.dart';
import 'package:quiz_app/view_models/notes_view_model.dart';
import 'package:quiz_app/view_models/questions_model.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => QuestionService());
  locator.registerLazySingleton(() => NotesService());

  locator.registerFactory(() => NotesViewModel());
  locator.registerFactory(() => QuestionsViewModel());
}