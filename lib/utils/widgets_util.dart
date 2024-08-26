import 'package:flutter/material.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'app_constant.dart';

final alertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descTextAlign: TextAlign.start,
  titleStyle: TextStyle(
    color: priorityColor[1],
    fontSize: FONT_SIZE_TITLE,
  ),
  descStyle: TextStyle(
    fontSize: FONT_SIZE_LABEL,
  ),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
);
