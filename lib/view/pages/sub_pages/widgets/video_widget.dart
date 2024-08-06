import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_playback_controller.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final VideoPlaybackController videoPlaybackController;

  const VideoWidget({
    Key? key,
    required this.videoUrl,
    required this.videoPlaybackController,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);

    _controller.addListener(() {
      if (_controller.value.isPlaying &&
          !widget.videoPlaybackController.isVideoPlaying.value) {
        widget.videoPlaybackController.isVideoPlaying.value = true;
      }
      if (_controller.value.position == _controller.value.duration) {
        widget.videoPlaybackController.isVideoPlaying.value = false;
      }
    });

    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
