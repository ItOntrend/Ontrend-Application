import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'video_playback_controller.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final VideoPlaybackController videoPlaybackController;

  const VideoWidget({
    super.key,
    required this.videoUrl,
    required this.videoPlaybackController,
  });

  @override
  // ignore: library_private_types_in_public_api
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
          return const ShimmerEffects();
        }
      },
    );
  }
}

class ShimmerEffects extends StatelessWidget {
  const ShimmerEffects({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 660.h,
      ),
    );
  }
}
