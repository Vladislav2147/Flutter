import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_4/util/percentage_sizes.dart';
import 'package:lab_4/values/dimens.dart';
import 'package:lab_4/values/styles.dart';

String defaultImage = 'https://www.whistles.com/dw/image/v2/BDCH_PRD/on/demandware.static/-/Sites-whistles-master-catalog/default/dwd305d41f/images/00103024627/whistles-alexandra-belted-coat-dark-green-03.jpg?sw=1429&sh=2000&strip=false';
String backgroundImage = '';

/// This is the main application widget.
class DetailsPage extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  DetailsPage([String? url]) {
    backgroundImage = url ?? defaultImage;
  }
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
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
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: getHeight(context, 0.8)),
        child: Container(
          height: 40.0,
          width: 40.0,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Stack(
            children: [
              Container(
                color: Colors.grey,
                width: getWidth(context),
                height: getHeight(context, 0.9),
                child: Image.network(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: getHeight(context, columnItemHeight),
                    width: getWidth(context, 4.0 / 7.0),
                    color: Colors.black.withOpacity(0.5),
                  )
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: getHeight(context, 0.75),
                    width: getWidth(context, 3.0 / 7.0),
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      children: [
                        Container(
                          height: getHeight(context, columnItemHeight),
                          width: 1000,
                          color: Colors.black.withOpacity(0.25),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: getHeight(context, columnItemPaddingTop),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NEW LOOK COAT",
                                  style: mainTextStyle(Colors.white),
                                ),
                                Text(
                                  "WOMEN",
                                  style: mainTextStyle(Colors.grey[400]!),
                                ),
                              ],
                            ),
                          )
                        ),
                        Container(
                            height: getHeight(context, columnItemHeight),
                            width: 1000,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                top: getHeight(context, columnItemPaddingTop),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PRICE",
                                    style: mainTextStyle(Colors.grey[400]!),
                                  ),
                                  Text(
                                    "120 \u20AC",
                                    style: mainTextStyle(Colors.white),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Container(
                            height: getHeight(context, columnItemHeight),
                            width: 1000,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, columnItemPaddingTop),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: TextButton.icon(
                                      onPressed: () { },
                                      label: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey[400],
                                      ),
                                      icon: Text(
                                        "SIZE",
                                        style: mainTextStyle(Colors.grey[400]!),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "M",
                                      style: mainTextStyle(Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Container(
                            height: getHeight(context, columnItemHeight),
                            width: 1000,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: getHeight(context, columnItemPaddingTop),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: TextButton.icon(
                                      onPressed: () { },
                                      label: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey[400],
                                      ),
                                      icon: Text(
                                        "COLOR",
                                        style: mainTextStyle(Colors.grey[400]!),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "GREEN",
                                      style: mainTextStyle(Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(
                          width: 1000,
                          height: getHeight(context, columnItemHeight),
                          child: ElevatedButton(
                            onPressed: () {},

                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text(
                              "ADD TO CART",
                              style: mainTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
