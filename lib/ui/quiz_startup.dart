import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:html/parser.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:quiz_app/common/constants.dart';
import 'package:quiz_app/common/viewstate.dart';
import 'package:quiz_app/view_models/questions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'base_view.dart';

class QuizStartup extends StatefulWidget {
  final bool isFromQuiz;

  QuizStartup({Key key, this.isFromQuiz}) : super(key: key);

  @override
  _QuizStartup createState() => _QuizStartup();
}

class _QuizStartup extends State<QuizStartup> {
  Timer _timer;
  int _start = 5;
  double opacityLevel = 1.0;
  bool isVertical = true;
  bool timerUp = false;
  double _questionAlignment = 80;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<int> _items = [];
  int counter = 0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    //getSharedPreferenceVal();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<QuestionsViewModel>(
      onModelReady: (model) {
        if (widget.isFromQuiz) model.resetQuestionNumber();
        if(model.questionNo == 0 && model.questionOne != null)
          model.setQuestionNumber(1);
        else if(model.questionNo == 1 && model.questionTwo != null)
          model.setQuestionNumber(2);
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: themeColor,
        body: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.deepPurple,
                ),
                //WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill),
                !timerUp
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Ready!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                //switchInCurve: Curves.decelerate,
                                switchOutCurve: Curves.easeInOutCubic,
                                switchInCurve: Curves.fastLinearToSlowEaseIn,
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      child: child, scale: animation);
                                },
                                child: Text(
                                  '$_start',
                                  key: ValueKey<int>(_start),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 120,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                if (timerUp)
                  FutureBuilder(
                      future: model.questionNo == 0
                          ? DefaultAssetBundle.of(context)
                              .loadString('assets/question_1.json')
                          : DefaultAssetBundle.of(context)
                              .loadString('assets/question_2.json'),
                      builder: (context, snapshot) {
                        if (model.questionNo == 0 &&
                            model.questionOne == null &&
                            widget.isFromQuiz == true)
                          model.getQuestionOne(snapshot.data.toString());
                        if (model.questionNo == 1 &&
                            model.questionTwo == null &&
                            widget.isFromQuiz == false)
                          model.getQuestionTwo(snapshot.data.toString());
                        return model.state == ViewState.Idle
                            ? AnimatedPositioned(
                                duration: Duration(seconds: 2),
                                bottom: _questionAlignment,
                                left: 10,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: model.questionNo == 1
                                      ? Text(
                                          parse(model
                                                  .questionOne[0].data.stimulus)
                                              .documentElement
                                              .text,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                              color: Colors.white),
                                        )
                                      : model.questionNo == 2
                                          ? Text(
                                              parse(model.questionTwo[0].data
                                                      .stimulus)
                                                  .documentElement
                                                  .text,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            )
                                          : Spacer(),
                                ))
                            : new Center(
                                child: new CircularProgressIndicator());
                      })
                else
                  SizedBox(),
                timerUp
                    ? Positioned(
                        child: Text(
                          "Oh My Quiz!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        left: 100,
                      )
                    : SizedBox(),
                /*timerUp
                    ? AnimatedPositioned(
                        duration: Duration(seconds: 2),
                        bottom: _questionAlignment,
                        left: 10,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "You need to define a fixed height to a horizontally scrollable widget. Please try wrapping your listview with a container or sized box with defined height",
                            maxLines: 3,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ))
                    : SizedBox(),*/
                timerUp
                    ? AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: 120,
                        left: 120,
                        child: CircularCountDownTimer(
                          duration: model.questionNo == 1
                              ? model.questionOne[0].data.metadata.duration
                              : (model.questionNo == 2
                                  ? model.questionTwo[0].data.metadata.duration
                                  : 30),
                          initialDuration: 0,
                          controller: CountDownController(),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 3,
                          ringColor: Colors.white,
                          ringGradient: null,
                          fillColor: Colors.red[500],
                          fillGradient: null,
                          backgroundColor: null,
                          backgroundGradient: null,
                          strokeWidth: 20.0,
                          strokeCap: StrokeCap.round,
                          textStyle: TextStyle(
                              fontSize: 33.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textFormat: CountdownTextFormat.S,
                          isReverse: true,
                          isReverseAnimation: true,
                          isTimerTextShown: true,
                          autoStart: true,
                          onStart: () {
                            print('Countdown Started');
                          },
                          onComplete: () {
                            print('Countdown Ended');
                          },
                        ),
                      )
                    : SizedBox(),
                timerUp
                    ? model.questionNo == 1
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                            child: SingleChildScrollView(
                              child: Container(
                                  child: verticalOptionsWithAnimation(model)),
                            ))
                        : model.questionNo == 2
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: gridOptions(model),
                                  ),
                                ))
                            : SizedBox()
                    : SizedBox()

                //isVertical?Positioned(child: verticalOptionsWithAnimation(),top: 100,left: 120):Positioned(child: gridOptions(),top: 100,left: 120,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 2);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            /* listKey.currentState.insertItem(0,
                duration: const Duration(milliseconds: 500));
            _items = []
              ..add(counter++)
              ..addAll(_items);*/
            _questionAlignment = 560;
            timerUp = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> getSharedPreferenceVal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showReadyOption = prefs.getBool(SHOW_READY_OPTION);
    if (showReadyOption)
      startTimer();
    else
      timerUp = true;
  }

  Widget verticalOptionsWithAnimation(QuestionsViewModel model) {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.questionOne[0].data.options.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "question_result",
                          arguments: index);
                    },
                    child: Hero(
                      tag: index,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(10),
                        child: new Container(
                          child: new Center(
                              child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new Text(
                                parse(model.questionOne[0].data.options[index]
                                        .label)
                                    .documentElement
                                    .text,
                              ),
                            ],
                          )),
                          padding: const EdgeInsets.all(15.0),
                        ),
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gridOptions(QuestionsViewModel model) {
    return GridView.count(
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 1.2,
      children:
          List.generate(model.questionTwo[0].data.options.length, (index) {
        return AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: 2,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, "question_result",
                      arguments: index);
                },
                child: Hero(
                  tag: "index",
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(10),
                    child: new Container(
                      child: new Center(
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(parse(model
                                  .questionTwo[0].data.options[index].label)
                              .documentElement
                              .text)
                        ],
                      )),
                      padding: const EdgeInsets.all(15.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
