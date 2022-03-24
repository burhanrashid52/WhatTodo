import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Tasks.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_app/utils/app_constant.dart';

class TaskRow extends StatelessWidget {
  final Tasks tasks;
  static final date_label = "Date";
  final List<String> labelNames = List();

  TaskRow(this.tasks);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO to click something
      },
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(PADDING_SMALL),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: priorityColor[tasks.priority.index],
                    ),
                  ),
                  height: 25.0,
                  width: 25.0,
                  child: ClipOval(
                    child: Container(
                      color: priorityColor[tasks.priority.index].withAlpha(75),
                    ),
                  ),
                ),
                SizedBox(width: 4.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                        child: Text(
                          tasks.title,
                          style: TextStyle(
                            fontSize: FONT_SIZE_TITLE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      getLabels(tasks.labelList),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: PADDING_SMALL,
                          bottom: PADDING_VERY_SMALL,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              getFormattedDate(tasks.dueDate),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: FONT_SIZE_DATE,
                              ),
                              key: Key(date_label),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        tasks.projectName,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: FONT_SIZE_LABEL,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        width: 8.0,
                                        height: 8.0,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Color(tasks.projectColor),
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
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
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
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
            left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
        child: Text(tasks.labelList.join("  "),
            style: TextStyle(fontSize: FONT_SIZE_LABEL)),
      );
    }
  }
}
