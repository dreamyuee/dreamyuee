import 'package:flutter/material.dart';
import 'dart:async';
class GifLoaderWithDynamicText extends StatefulWidget {
  @override
  _GifLoaderWithDynamicTextState createState() => _GifLoaderWithDynamicTextState();
}

class _GifLoaderWithDynamicTextState extends State<GifLoaderWithDynamicText> {
  List<String> messages = [
    "Preparing your experience...",
    "Loading assets...",
    "Just a moment...",
    "Almost there!",
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Cycle through the messages every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % messages.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/loading.gif',
              width: 150.0,
              height: 150.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              messages[currentIndex],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
