import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_4/util/percentage_sizes.dart';
import 'package:lab_4/values/colors.dart';
import 'package:lab_4/values/dimens.dart';
import 'package:lab_4/values/styles.dart';
import 'package:lab_4/widgets/details_page/DetailsPage.dart';


/// This is the main application widget.
class PlatformPage extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

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
  String _battery = "--%";
  static const platform = const MethodChannel('com.shichko.lab6/battery_channel');

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel', {"default_level": -10});
      batteryLevel = '$result%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _battery = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _battery,
              style: GoogleFonts.teko(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
                onPressed: _getBatteryLevel,
                child: Text(
                    "Get",
                    style: GoogleFonts.teko(
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
