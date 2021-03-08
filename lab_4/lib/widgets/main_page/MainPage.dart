import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_4/util/percentage_sizes.dart';
import 'package:lab_4/values/colors.dart';
import 'package:lab_4/values/dimens.dart';
import 'package:lab_4/values/styles.dart';
import 'BottomCarouselWidget.dart';
import 'MainCarouselWidget.dart';


/// This is the main application widget.
class MainPage extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: getWidth(context),
            height: getHeight(context),
          ),
          Container(
            width: getWidth(context, 0.55),
            height: getHeight(context, 0.5),
            color: Colors.grey[500],
          ),
          Positioned(
            right: 0,
            child: Container(
              width: getWidth(context, 0.85),
              height: getHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getHeight(context, 0.1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "NEW COLLECTION",
                          style: mainTextStyle(Colors.black, FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  MainCarouselStatefulWidget(),
                  Container(
                    height: getHeight(context, 0.1),
                    child: Padding(
                      padding: EdgeInsets.only(top: getHeight(context, 0.02)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "YOU MAY LIKE",
                            style: mainTextStyle(Colors.black, FontWeight.w500),
                          ),
                          TextButton.icon(
                            onPressed: () { },
                            label:Icon(
                              Icons.chevron_right,
                              color: mainColor,
                            ),
                            icon: Text(
                              "MORE",
                              style: mainTextStyle(mainColor, FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomCarouselWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Main",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: "Account",
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: mainColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}
