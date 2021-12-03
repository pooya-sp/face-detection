import 'dart:io';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/camera_state_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_state_bloc/events/picture_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class DisplayVideoScreen extends StatefulWidget {
  static const routName = '/display-video';
  @override
  _DisplayVideoScreenState createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeController;
  var _isInit = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      context.read<CameraStateBloc>().add(VideoRequested());
      var videoPath = ModalRoute.of(context).settings.arguments as String;
      _controller = VideoPlayerController.file(File(videoPath));
      _initializeController = _controller.initialize();
      _isInit = true;
    }
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
                extendBodyBehindAppBar: true,
                appBar: AppBar(backgroundColor: Colors.transparent),
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
