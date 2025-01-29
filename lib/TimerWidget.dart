import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

const textStyle = TextStyle(
  fontSize: 50,
);

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int secondValue = 0;
  int minuteValue = 0;
  int hourValue = 0;
  int sec = 0;
  int minute = 0;
  int hour = 0;
  bool isNotActive = true;
  bool isPause = false;
  Timer? timer;

  double progressValue = 1;
  Duration duration = Duration();
  Duration initialDuration = Duration();




  void stop() {
    timer?.cancel();
    setState(() {
      progressValue = 1;
      isNotActive = true;
    });
  }
  void start() {
    setState(() {
      isNotActive = false;
      duration = Duration(
        hours: hourValue,
        minutes: minuteValue,
        seconds: secondValue,
      );
      initialDuration = duration;
      sec  = duration.inSeconds.remainder(60);
      minute  = duration.inMinutes.remainder(60);
      hour  = duration.inHours.remainder(24);
    });

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        final seconds = duration.inSeconds - 1;

        if (seconds < 0) {
            stop();
        } else {
          setState(() {
            duration = Duration(seconds: seconds);
            progressValue = duration.inSeconds / initialDuration.inSeconds;
            sec = duration.inSeconds.remainder(60);
            minute = duration.inMinutes.remainder(60);
            hour = duration.inHours.remainder(24);
          });
        }
      },
    );
  }


  void reset () {
    timer?.cancel();

    setState(() {
      progressValue = 1;
      duration = Duration(
        hours: hourValue,
        minutes: minuteValue,
        seconds: secondValue,
      );
      initialDuration = duration;
      sec  = duration.inSeconds.remainder(60);
      minute  = duration.inMinutes.remainder(60);
      hour  = duration.inHours.remainder(24);
    });
    timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        final seconds = duration.inSeconds - 1;

        if (seconds < 0) {
          stop();
        } else {
          setState(() {
            duration = Duration(seconds: seconds);
            progressValue = duration.inSeconds / initialDuration.inSeconds;
            sec = duration.inSeconds.remainder(60);
            minute = duration.inMinutes.remainder(60);
            hour = duration.inHours.remainder(24);
          });
        }
      },
    );
  }
  void pause () {
    timer?.cancel();
    setState(() {
      isPause = true;
      duration = Duration(hours: hour, minutes: minute,seconds: sec);
      sec = duration.inSeconds.remainder(60);
      minute = duration.inMinutes.remainder(60);
      hour = duration.inHours.remainder(24);
    });
  }

  void resume () {
    setState(() {
      isPause = false;
      duration = Duration(hours: hour, minutes: minute,seconds: sec);
      // initialDuration = duration;
      sec = duration.inSeconds.remainder(60);
      minute = duration.inMinutes.remainder(60);
      hour = duration.inHours.remainder(24);
    });
    timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        final seconds = duration.inSeconds - 1;

        if (seconds < 0) {
          stop();
        } else {
          setState(() {
            duration = Duration(seconds: seconds);
            progressValue = duration.inSeconds / initialDuration.inSeconds;

            sec = duration.inSeconds.remainder(60);
            minute = duration.inMinutes.remainder(60);
            hour = duration.inHours.remainder(24);
          });
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isNotActive
              ? Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 1,
                        child: NumberPicker(
                          minValue: 0,
                          maxValue: 24,
                          value: hourValue,
                          onChanged: (value) {
                            setState(() {
                              hourValue = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: minuteValue,
                          onChanged: (value) {
                            setState(() {
                              minuteValue = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: secondValue,
                          onChanged: (value) {
                            setState(() {
                              secondValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: progressValue,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.green.shade900),
                            backgroundColor: Colors.greenAccent,
                            strokeWidth: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  hour.toString().padLeft(2, '0'),
                                  style: textStyle.copyWith(
                                      color: Colors.blue.shade800),
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
                                  style: textStyle.copyWith(
                                      color: Colors.blue.shade800),
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
                                  style: textStyle.copyWith(
                                      color: Colors.blue.shade800),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          isNotActive
              ? Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => start(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.green),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () => stop(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35.0),
                                  color: Colors.red),
                              child: Text(
                                "Stop",
                                style: TextStyle(
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
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                color: Colors.grey.shade500),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          SizedBox(
            height: 30,
          ),

          isNotActive
              ? SizedBox()
              : Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => isPause? resume(): pause(),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    color:isPause? Colors.deepPurple : Colors.blue.shade600),
                child: Text( isPause? "Resume" :
                  "Pause",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
