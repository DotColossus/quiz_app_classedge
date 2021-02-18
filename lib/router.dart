

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/ui/home_view.dart';
import 'package:quiz_app/ui/question_result.dart';
import 'package:quiz_app/ui/quiz_startup.dart';
import 'package:quiz_app/ui/quiz_video.dart';
import 'package:quiz_app/ui/splash_screen.dart';



const String initialRoute = "splash";

class RouterNavigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => QuizVideo());
      case 'topics':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'quiz_startup':
        bool isFromQuiz = settings.arguments;
        return MaterialPageRoute(builder: (_) => QuizStartup( isFromQuiz:isFromQuiz,));
      case 'question_result':
        int index = settings.arguments;
        return MaterialPageRoute(builder: (_) => QuestionResult(index: index,));
    }
  }
}
