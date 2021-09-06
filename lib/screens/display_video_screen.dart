import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class DisplayVideoScreen extends StatefulWidget {
  static const routName = '/display-video';
  @override
  _DisplayVideoScreenState createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var videoPath = ModalRoute.of(context)!.settings.arguments as String;
    _controller = VideoPlayerController.file(File(videoPath));
    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializeController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            _controller.setLooping(true);
            return Scaffold(
                appBar: AppBar(title: const Text('Display the Video')),
                body: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    )));
          }
        });
  }
}
