import 'dart:async';

import 'package:app_03_stopwatch/laps.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  List<List<String>> _laps = []; // [lapTimes, overallTime]

  void _startStopwatch() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {
      _laps = [];
    });
  }

  void _resumeStopwatch() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  String _formatTime(int milliSeconds) {
    final minutes = ((milliSeconds / 1000) / 60).toInt();
    final seconds = ((milliSeconds / 1000) % 60).toInt();
    milliSeconds = ((milliSeconds % 1000) / 10).floor();
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}.${milliSeconds.toString().padLeft(2, "0")}';
  }

  int parseMilliseconds(String time) {
    final splitted = time.split(".");
    final minutes = int.parse(splitted[0].split(":")[0]);
    final seconds = int.parse(splitted[0].split(":")[1]);
    final milliseconds = int.parse(splitted[1]);
    return minutes * 1000 * 60 + seconds * 1000 + milliseconds;
  }

  void _makeLap() {
    final milliSeconds = _stopwatch.elapsedMilliseconds;
    final lapTime = _laps.isEmpty
        ? _formatTime(milliSeconds)
        : _formatTime(milliSeconds - parseMilliseconds(_laps.last[1]));
    final overallTime = _formatTime(milliSeconds);
    _laps.add([lapTime, overallTime]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 60),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50),
              Text(
                _formatTime(_stopwatch.elapsedMilliseconds),
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),

              if (_laps.isNotEmpty) Expanded(child: Laps(laps: _laps)),

              const SizedBox(height: 40),

              Builder(
                builder: (context) {
                  // Not Started Yet
                  if (_stopwatch.elapsedMilliseconds == 0 &&
                      !_stopwatch.isRunning) {
                    return FilledButton(
                      onPressed: _startStopwatch,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 34,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                  // Running
                  if (_stopwatch.isRunning &&
                      _stopwatch.elapsedMilliseconds != 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FilledButton(
                          onPressed: _makeLap,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: EdgeInsets.symmetric(
                              horizontal: 34,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            "Lap",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        FilledButton(
                          onPressed: _stopStopwatch,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              horizontal: 34,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Stopped
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          padding: EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 8,
                          ),
                        ),
                        onPressed: _resetStopwatch,
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: _resumeStopwatch,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          "Resume",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
