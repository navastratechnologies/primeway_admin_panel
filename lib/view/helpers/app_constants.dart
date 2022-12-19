import 'package:flutter/material.dart';

Color whiteColor = Colors.white;
Color mainColor = const Color(0xffE5283C);
Color mainShadeColor = const Color(0xffF25C6D);
Color elevationColor = Colors.black.withOpacity(0.1);
Color greenShadeColor = const Color(0xff17D29C);
Color greenLightShadeColor = const Color(0xff5CE2B9);
Color greenSelectedColor = Colors.green[900]!;
Color orange = Colors.orange;
Color yellow = Colors.yellow;
Color purpleColor = const Color(0xff8043F9);

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

Size displaySize(BuildContext context) {
  debugPrint('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  debugPrint('Height = ${displaySize(context).height}');
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  debugPrint('Width = ${displaySize(context).width}');
  return displaySize(context).width;
}
