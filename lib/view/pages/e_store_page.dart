import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EStorePage extends StatefulWidget {
  const EStorePage({super.key});

  @override
  _EStorePageState createState() => _EStorePageState();
}

class _EStorePageState extends State<EStorePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/videos/E_Store_comming_soon.mp4")
          ..initialize().then((_) {
            setState(() {
              _controller.setLooping(true); // Enable looping
              _controller
                  .play(); // Optionally start playing the video automatically
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(), // Show a loading indicator while the video is loading
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
