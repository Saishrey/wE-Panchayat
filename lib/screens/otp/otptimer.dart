import 'dart:async';
import 'package:flutter/material.dart';

class OtpTimer extends StatefulWidget {
  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    var _timer = this._timer;
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes.toString().padLeft(1, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Resend OTP in ${_formatTime(_secondsLeft)}.',
      style: TextStyle(
        color: Colors.black54, // or any other color you want
        // fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
