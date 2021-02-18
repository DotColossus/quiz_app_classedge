import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:quiz_app/common/constants.dart';
import 'package:quiz_app/view_models/questions_model.dart';

import 'base_view.dart';

class QuestionResult extends StatefulWidget {
  final int index;

  QuestionResult({Key key, this.index}) : super(key: key);

  @override
  _QuestionResultState createState() => _QuestionResultState();
}

class _QuestionResultState extends State<QuestionResult> {
  bool _showFrontSide;
  bool _flipXAxis;
  Timer _timer;
  int _start = 4;
  int isQuizEnd = 1;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 3) {
          setState(() {
            _switchCard();

            _start--;
          });
        } else if (_start == 1) {
          if (isQuizEnd == 1)
            Navigator.popAndPushNamed(context, "quiz_startup",
                arguments: false);
          if (isQuizEnd == 2) {
            setState(() {
              isQuizEnd = 3;
            });
          }
          _timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<QuestionsViewModel>(
      onModelReady: (model) {
        if (model.questionNo == 2) isQuizEnd = 2;
        if (model.questionNo == 1 &&
            model.questionOne[0].data.options[widget.index].isCorrect == 0)
          isQuizEnd = 2;
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: themeColor,
        body: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.deepPurple,
            body: isQuizEnd != 3
                ? DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints.tight(Size.square(200.0)),
                        child: Hero(
                          tag: "index",
                          child: _buildFlipAnimation(model),
                        ),
                      ),
                    ),
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Column(
                        children: [
                          Spacer(flex: 3),
                          Text(
                            "Score",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: kSecondaryColor),
                          ),
                          Spacer(),
                          Text(
                            "20",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: kSecondaryColor),
                          ),
                          Spacer(flex: 3),
                          RaisedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Done"),
                          )
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation(QuestionsViewModel model) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: _showFrontSide ? _buildFront(model) : _buildRear(model),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront(QuestionsViewModel model) {
    return __buildLayout(
        key: ValueKey(true),
        side: 1,
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
            child: FlutterLogo(),
          ),
        ),
        model: model);
  }

  Widget _buildRear(QuestionsViewModel model) {
    return __buildLayout(
        key: ValueKey(false),
        side: 2,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
            child: Center(
                child: Text("Flutter", style: TextStyle(fontSize: 50.0))),
          ),
        ),
        model: model);
  }

  Widget __buildLayout(
      {Key key, Widget child, int side, Icon icon, QuestionsViewModel model}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            side == 1
                ? model.questionNo == 1
                    ? Text(
                        parse(model.questionOne[0].data.options[widget.index]
                                .label)
                            .documentElement
                            .text,
                        style: TextStyle(fontSize: 24, color: Colors.black87),
                      )
                    : Text(
                        parse(model.questionTwo[0].data.options[widget.index]
                                .label)
                            .documentElement
                            .text,
                        style: TextStyle(fontSize: 24, color: Colors.black87),
                      )
                : SizedBox(),
            side == 2
                ? model.questionNo == 1
                    ? model.questionOne[0].data.options[widget.index]
                                .isCorrect ==
                            1
                        ? Icon(Icons.done_rounded,
                            color: Colors.green, size: 100)
                        : Icon(Icons.error_rounded,
                            color: Colors.red, size: 100)
                    : model.questionTwo[0].data.options[widget.index]
                                .isCorrect ==
                            1
                        ? Icon(Icons.done_rounded,
                            color: Colors.green, size: 100)
                        : Icon(Icons.error_rounded,
                            color: Colors.red, size: 100)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
