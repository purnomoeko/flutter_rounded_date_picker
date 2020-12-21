import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:flutter_rounded_date_picker_example/calendar_exm.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime dateTime;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Date Time selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "$dateTime",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Duration Selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  Text(
                    "$duration",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 50),
              children: <Widget>[
                const SizedBox(height: 16),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DialogCalendar.show(
                      context: context,
                      selectedDay: DateTime.now(),
                      barrierDismissible: true,
                      height: 460,
                      onPressDay: (DateTime time) {
                        setState(() => dateTime = time);
                      },
                    );
                  },
                  label: const Text("Material Calendar (Original)"),
                ),
                const SizedBox(height: 24),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DialogCalendar.show(
                      context: context,
                      transitionBuilder: (BuildContext context,
                          Animation<double> anim1,
                          Animation<double> anim2,
                          Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0))
                              .animate(anim1),
                          child: child,
                        );
                      },
                      selectedDay: DateTime.now(),
                      barrierDismissible: true,
                      onPressDay: (DateTime time) {
                        setState(() => dateTime = time);
                      },
                    );
                  },
                  label: const Text("Material Calendar (Original)"),
                ),
                const SizedBox(height: 24),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DialogCalendar.show(
                      context: context,
                      showHeader: true,
                      selectedDay: DateTime.now(),
                      onPressDay: (DateTime time) {
                        setState(() => dateTime = time);
                      },
                    );
                  },
                  label: const Text("Material Calendar (Original) with Header"),
                ),
                const SizedBox(height: 24),
                FloatingActionButton.extended(
                  onPressed: () async {
                    CupertinoRoundedDurationPicker.show(
                      context,
                      initialTimerDuration: duration,
                      initialDurationPickerMode: CupertinoTimerPickerMode.hms,
                      fontFamily: "Mali",
                      onDurationChanged: (newDuration) {
                        setState(() => duration = newDuration);
                      },
                    );
                  },
                  label: const Text("Cupertino Rounded Duration Picker"),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rounded Date Picker'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: _buildBody(),
      ),
    );
  }
}
