import 'package:flutter/material.dart';

var priorityColor = [Colors.red, Colors.orange, Colors.yellow, Colors.white];

class ColorPalette {
  final String colorName;
  final int colorValue;

  ColorPalette(this.colorName, this.colorValue);
}

var colorsPalettes = <ColorPalette>[
  new ColorPalette("Red", Colors.red.value),
  new ColorPalette("Pink", Colors.pink.value),
  new ColorPalette("Purple", Colors.purple.value),
  new ColorPalette("Deep Purple", Colors.deepPurple.value),
  new ColorPalette("Indigo", Colors.indigo.value),
  new ColorPalette("Blue", Colors.blue.value),
  new ColorPalette("Lightblue", Colors.lightBlue.value),
  new ColorPalette("Cyan", Colors.cyan.value),
  new ColorPalette("Teal", Colors.teal.value),
  new ColorPalette("Green", Colors.green.value),
  new ColorPalette("Lightgreen", Colors.lightGreen.value),
  new ColorPalette("Lime", Colors.lime.value),
  new ColorPalette("Yellow", Colors.yellow.value),
  new ColorPalette("Amber", Colors.amber.value),
  new ColorPalette("Orange", Colors.orange.value),
  new ColorPalette("Deeporange", Colors.deepOrange.value),
  new ColorPalette("Brown", Colors.brown.value),
  new ColorPalette("Black", Colors.black.value),
  new ColorPalette("Grey", Colors.grey.value),
];
