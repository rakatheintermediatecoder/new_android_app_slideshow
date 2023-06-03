import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'myVideoPlayer.dart';

void main() {
  runApp(const MyApp());
}

void videoPlayer() {
  runApp(const MyVideoApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SlideshowWidget(),
          ),
        ),
      ),
    );
  }
}

class SlideshowWidget extends StatefulWidget {
  const SlideshowWidget({Key? key}) : super(key: key);

  @override
  SlideshowWidgetState createState() => SlideshowWidgetState();
}

class SlideshowWidgetState extends State<SlideshowWidget> {
  int currentIndex = 0;
  List<SlideshowImage> images = [
    SlideshowImage("assets/p2.jpeg", const Duration(seconds: 5)),
    SlideshowImage("assets/p3.jpeg", const Duration(seconds: 3)),
    SlideshowImage("assets/p4.jpeg", const Duration(seconds: 8)),
    // Add more images as needed
  ];
  late Timer timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = images[currentIndex];
    final currentDuration = currentImage.duration;
    timer.cancel();
    timer = Timer(currentDuration, () {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
      startTimer();
    });

    return Image.asset(
      currentImage.path,
      fit: BoxFit.fill,
    );
  }
}

class SlideshowImage {
  final String path;
  final Duration duration;

  SlideshowImage(this.path, this.duration);
}
