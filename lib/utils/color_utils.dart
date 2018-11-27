import 'package:flutter/material.dart';

var priorityColor = [Colors.red, Colors.orange, Colors.yellow, Colors.white];

class ColorPalette {
  final String colorName;
  final int colorValue;

  ColorPalette(this.colorName, this.colorValue);
}

var colorsPalettes = <ColorPalette>[
  ColorPalette("Red", Colors.red.value),
  ColorPalette("Pink", Colors.pink.value),
  ColorPalette("Purple", Colors.purple.value),
  ColorPalette("Deep Purple", Colors.deepPurple.value),
  ColorPalette("Indigo", Colors.indigo.value),
  ColorPalette("Blue", Colors.blue.value),
  ColorPalette("Lightblue", Colors.lightBlue.value),
  ColorPalette("Cyan", Colors.cyan.value),
  ColorPalette("Teal", Colors.teal.value),
  ColorPalette("Green", Colors.green.value),
  ColorPalette("Lightgreen", Colors.lightGreen.value),
  ColorPalette("Lime", Colors.lime.value),
  ColorPalette("Yellow", Colors.yellow.value),
  ColorPalette("Amber", Colors.amber.value),
  ColorPalette("Orange", Colors.orange.value),
  ColorPalette("Deeporange", Colors.deepOrange.value),
  ColorPalette("Brown", Colors.brown.value),
  ColorPalette("Black", Colors.black.value),
  ColorPalette("Grey", Colors.grey.value),
];
