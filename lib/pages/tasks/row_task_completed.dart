import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_app/utils/app_constant.dart';

class TaskCompletedRow extends StatelessWidget {
  final Tasks tasks;
  static final date_label = "Date";
  List<String> labelNames = new List();

  TaskCompletedRow(this.tasks);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        //TODO to click something
      },
      child: new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.symmetric(vertical: PADDING_TINY),
            decoration: new BoxDecoration(
              border: new Border(
                left: new BorderSide(
                  width: 4.0,
                  color: priorityColor[tasks.priority.index],
                ),
              ),
            ),
            child: new Padding(
              padding: const EdgeInsets.all(PADDING_SMALL),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: new Text(tasks.title,
                        style: new TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: FONT_SIZE_TITLE,
                            fontWeight: FontWeight.bold)),
                  ),
                  getLabels(tasks.labelList),
                  new Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          getFormattedDate(tasks.dueDate),
                          style: new TextStyle(
                              color: Colors.grey, fontSize: FONT_SIZE_DATE),
                          key: new Key(date_label),
                        ),
                        new Expanded(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new Text(tasks.projectName,
                                      style: new TextStyle(
                                          color: Colors.grey,
                                          fontSize: FONT_SIZE_LABEL)),
                                  new Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    width: 8.0,
                                    height: 8.0,
                                    child: new CircleAvatar(
                                      backgroundColor:
                                          new Color(tasks.projectColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
              decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget getLabels(List<String> labelList) {
    if (labelList.isEmpty) {
      return new Container();
    } else {
      return new Padding(
        padding: const EdgeInsets.only(
            left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
        child: new Text(tasks.labelList.join("  "),
            style: new TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: FONT_SIZE_LABEL)),
      );
    }
  }
}
