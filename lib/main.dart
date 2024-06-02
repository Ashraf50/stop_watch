import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.black),
      ),
      home: StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _startStopwatch() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          _milliseconds += 100;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _stopStopwatch() {
    if (_isRunning) {
      _timer?.cancel();

      setState(() {
        _isRunning = false;
      });
    }
  }

  void _resetStopwatch() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    seconds = seconds % 60;
    minutes = minutes % 60;
    hours = hours % 24;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${(milliseconds % 1000).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Stopwatch Timer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_milliseconds),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _resetStopwatch();
                  },
                  child: Container(
                    padding: EdgeInsets.all(27),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff333333)),
                    child: Center(
                        child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _isRunning ? _stopStopwatch() : _startStopwatch();
                  },
                  child: Container(
                    padding: EdgeInsets.all(27),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _isRunning ? Color(0xff340e0b) : Color(0xff092911)),
                    child: Center(
                        child: Text(
                      _isRunning ? 'Stop' : 'Start',
                      style: TextStyle(
                          color: _isRunning ? Colors.red : Colors.green),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
