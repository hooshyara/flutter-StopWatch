import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'StopWatch.dart';
import 'TimerWidget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  List <Widget> pageList = [
    StopwatchdWidget(),
    TimerWidget()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          selectedFontSize: 18,
          unselectedFontSize: 15,
          backgroundColor: Colors.grey.shade100,
          elevation: 12,
          selectedItemColor: Color(0xFF365DAC),
          unselectedItemColor: Colors.grey.shade600,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.lock_clock,
                  size: 32,
                ),
                label: "StopWatch"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.timer,
                  size: 32,
                ),
                label: "Timer"),
          ]),
      body: pageList[currentIndex],
    );
  }
}
