import 'dart:async';

import 'package:flutter/material.dart';

const textStyle = TextStyle(
  fontSize: 50,
);


class StopwatchdWidget extends StatefulWidget {
  const StopwatchdWidget({
    super.key,
  });

  @override
  State<StopwatchdWidget> createState() => _StopwatchdWidgetState();
}

class _StopwatchdWidgetState extends State<StopwatchdWidget> {
  int sec = 0;
  int minute = 0;
  int hour = 0;
  Duration myDuration = Duration(seconds: 0);
  Timer? timer;
  bool isActive = false;

  void start() {
    setState(() {
      isActive = true;
    });
    timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        // final seconds = myDuration.inSeconds + 1;
        myDuration += Duration(seconds: 1);

        setState(() {
          sec = myDuration.inSeconds.remainder(60);
          minute = myDuration.inMinutes.remainder(60);
          hour = myDuration.inHours.remainder(24);
        });
      },
    );
  }

  void stop() {
    timer?.cancel();
    setState(() {
      isActive = false;
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      isActive = false;
      myDuration = Duration(seconds: 0);
      sec = 0;
      minute = 0;
      hour = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    hour.toString().padLeft(2, '0'),
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ":",
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    minute.toString().padLeft(2, '0'),
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ":",
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    sec.toString().padLeft(2, '0'),
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => isActive ? stop() : start(),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      color: isActive ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      isActive ? "Stop" : "Start",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => reset(),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      color: Colors.grey.shade500,
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
