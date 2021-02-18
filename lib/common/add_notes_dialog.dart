import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/notes_model.dart';
import 'package:quiz_app/view_models/notes_view_model.dart';

class CustomDialogBox extends StatefulWidget {
  final NotesViewModel model;
  final BuildContext ctx;
  final int duration;

  const CustomDialogBox({Key key, this.model, this.ctx,this.duration}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  FocusNode inputOne = FocusNode();
  TextEditingController noteController = new TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.3,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(width: 4),
                  Icon(
                    Icons.addchart_sharp,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 2),
                  Text("Create Notes"),
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(widget.ctx).pop();
                  })
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Add Note",
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  hintText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  )),
              minLines: 5,
              maxLines: 6,
              autofocus: false,
              focusNode: inputOne,
              controller: noteController,
            ),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                noteController.text.isEmpty ? _validate = true : _validate = false;
              });
              if (!_validate) {
                String notes = noteController.text;
                Notes obj = new Notes(notes, widget.duration);
                widget.model.addNotes(obj);
                Navigator.of(widget.ctx).pop();
              }
            },
            child: Text('Save Note'),
          )
        ],
      ),
    );
  }
}
