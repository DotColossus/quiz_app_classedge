import 'dart:async';
import 'dart:convert';

import 'package:chewie/chewie.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:quiz_app/common/add_notes_dialog.dart';
import 'package:quiz_app/common/constants.dart';
import 'package:quiz_app/common/viewstate.dart';
import 'package:quiz_app/models/settings.dart';
import 'package:quiz_app/view_models/notes_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'base_view.dart';

class QuizVideo extends StatefulWidget {
  QuizVideo({Key key}) : super(key: key);

  @override
  _QuizVideo createState() => _QuizVideo();
}

class _QuizVideo extends State<QuizVideo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  List<int> noteList = new List();
  bool showNotes = false, showQuiz;
  int currentIndex;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    /*   _videoPlayerController = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');*/
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/indian_history.mp4')
          ..addListener(() {
            if (_videoPlayerController.value.duration
                        .compareTo(_videoPlayerController.value.position) ==
                    0 ||
                _videoPlayerController.value.duration
                        .compareTo(_videoPlayerController.value.position) ==
                    -1) {
              setState(() {
                Navigator.popAndPushNamed(context, "quiz_startup",arguments: true);
              });
            } else if (noteList.length != 0 && showNotes == false) if (noteList
                .contains(_videoPlayerController.value.position.inSeconds)) {
              currentIndex = noteList.indexOf(_videoPlayerController.value.position.inSeconds);
              Timer(Duration(seconds: 3), () {
                _chewieController.pause();
                showNotes = true;
                setState(() {});
              });
            }
          });
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotesViewModel>(
      onModelReady: (model) {
        if (model.notesList != null && model.notesList.length != 0)
          model.notesList.forEach((element) {
            noteList.add(element.duration);
          });
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: themeColor,
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Tata ClassEdge"),
                  ),
                  backgroundColor: themeColor,
                  body: Column(
                    children: [
                      Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        child: _chewieController != null &&
                                _chewieController
                                    .videoPlayerController.value.initialized
                            ? Chewie(
                                controller: _chewieController,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Loading'),
                                ],
                              ),
                      ),
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          topicInfo(model, context),
                          showNotes == true
                              ? overlayContainer(context,model)
                              : SizedBox()
                        ],
                      )),
                      FutureBuilder(
                          future: DefaultAssetBundle.of(context)
                              .loadString('assets/settings.json'),
                          builder: (context, snapshot) {
                            parseSettings(snapshot.data.toString());
                            return SizedBox();
                          })
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget topicInfo(NotesViewModel mModel, BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Know about Indian History"),
              ),
              RaisedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          model: mModel,
                          ctx: mContext,
                          duration:
                              _videoPlayerController.value.position.inSeconds,
                        );
                      });
                },
                child: Text("Add Notes"),
              )
            ],
          ),
          Text(
              "India's history and culture is dynamic, spanning back to the beginning of human civilization. It begins with a mysterious culture along the Indus River and in farming communities in the southern lands of India. ... By the end of the fourth millennium BC, India had emerged as a region of highly developed civilization."),
        ],
      ),
    );
  }

  Widget overlayContainer(BuildContext mContext,NotesViewModel model) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Added Notes here!!!"),
          InkWell(
            onTap: () {
              showNotes = false;
              if (!_chewieController.isPlaying) _chewieController.play();
              setState(() {
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 3,
                    spreadRadius: 6,
                  )
                ],
              ),
              child: Text(
                  model.notesList[currentIndex].notesDetails)
            ),
          )
        ],
      ),
    );
  }

  Future<Settings> parseSettings(String response) async {
    if (response == null) {
      return Settings();
    }
    Map userMap = jsonDecode(response);
    var user = Settings.fromJson(userMap);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SHOW_READY_OPTION, user.showQuizStarterTimer);
    prefs.setBool(SHOW_COUNTDOWN_TIMER, user.showCountdownProgress);
    return user;
  }
}
