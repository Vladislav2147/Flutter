import 'package:flutter/widgets.dart';

double getWidth(BuildContext context, [double size = 1]) {
  return MediaQuery.of(context).size.width * size;
}

double getHeight(BuildContext context, [double size = 1]) {
  return MediaQuery.of(context).size.height * size;
}