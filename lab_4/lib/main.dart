import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_4/widgets/details_page/DetailsPage.dart';
import 'package:lab_4/widgets/main_page/MainPage.dart';
import 'package:lab_4/widgets/platform_page/PlatformPage.dart';

void main() => runApp(ClothApp());

class ClothApp extends StatelessWidget {
  final PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageView(
        controller: _controller,
        children: [
          PlatformPage(),
          MainPage(),
          DetailsPage(),
        ],
      )
    );
  }
}