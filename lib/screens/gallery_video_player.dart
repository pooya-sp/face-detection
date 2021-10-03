import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/events/gallery_video_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/gallery_video_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/states/gallery_video_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoPlayer extends StatefulWidget {
  final Medium medium;
  GalleryVideoPlayer(this.medium);
  @override
  State<GalleryVideoPlayer> createState() => _GalleryVideoPlayerState();
}

class _GalleryVideoPlayerState extends State<GalleryVideoPlayer> {
  @override
  void initState() {
    super.initState();
    context.read<GalleryVideoBloc>().add(GalleryVideoInitialize(widget.medium));
  }

  var _isPlayIconHidden = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryVideoBloc, GalleryVideoState>(
        builder: (ctx, state) {
      if (state is GalleryVideoLoadingComplete) {
        return Stack(
          children: [
            GestureDetector(
                onTap: () {
                  _isPlayIconHidden = !_isPlayIconHidden;
                  context.read<GalleryVideoBloc>().add(MakePLayIconHidden());
                },
                child: VideoPlayer(state.controller)),
            AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: _isPlayIconHidden ? 0 : 1,
                child: GestureDetector(
                  onTap: () {
                    if (state.controller.value.isPlaying) {
                      context.read<GalleryVideoBloc>().add(PauseRequested());
                    } else {
                      context.read<GalleryVideoBloc>().add(PlayRequested());
                    }
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(
                        state.controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  ),
                )),
          ],
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text("Something went wrong"),
          ),
        );
      }
    });
  }
}
