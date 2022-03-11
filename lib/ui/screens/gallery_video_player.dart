import 'package:face_detection_app/business_logic/Blocs/gallery_items_bloc/states/gallery_states.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/events/gallery_video_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/gallery_video_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_video_bloc/states/gallery_video_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:volume_control/volume_control.dart';

class GalleryVideoPlayer extends StatefulWidget {
  final Medium medium;
  const GalleryVideoPlayer(this.medium);
  @override
  State<GalleryVideoPlayer> createState() => _GalleryVideoPlayerState();
}

class _GalleryVideoPlayerState extends State<GalleryVideoPlayer> {
  VideoPlayerController videoPlayerController;
  double deviceVolume;
  @override
  void initState() {
    super.initState();
    VolumeControl.volume.then((value) => deviceVolume = value);
    context.read<GalleryVideoBloc>().add(GalleryVideoInitialize(widget.medium));
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  var _isPlayIconHidden = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryVideoBloc, GalleryVideoState>(
        listener: (ctx, state) {
      if (state is GalleryVideoLoadingComplete) {
        videoPlayerController = state.videoPlayerController;
        if (!state.videoPlayerController.hasListeners) {
          state.videoPlayerController.addListener(() {
            if (state.videoPlayerController.value.position ==
                state.videoPlayerController.value.duration) {
              context.read<GalleryVideoBloc>().add(PlayRequested());
            }
          });
        }
      }
    }, builder: (ctx, state) {
      if (state is GalleryVideoIsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is GalleryVideoLoadingComplete) {
        return Stack(
          children: [
            GestureDetector(
                onTap: () {
                  _isPlayIconHidden = !_isPlayIconHidden;
                  context.read<GalleryVideoBloc>().add(MakePLayIconHidden());
                },
                child: VideoPlayer(state.videoPlayerController)),
            AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: _isPlayIconHidden ? 0 : 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 32),
                      height: 60,
                      width: 60,
                      child: IconButton(
                        onPressed: () {
                          if (state.videoPlayerController.value.isPlaying) {
                            context
                                .read<GalleryVideoBloc>()
                                .add(PauseRequested());
                          } else {
                            context
                                .read<GalleryVideoBloc>()
                                .add(PlayRequested());
                          }
                        },
                        icon: Icon(
                          state.videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: IconButton(
                        onPressed: () {
                          if (state.videoPlayerController.value.volume == 0) {
                            state.videoPlayerController.setVolume(deviceVolume);
                          } else {
                            state.videoPlayerController.setVolume(0);
                          }
                          context
                              .read<GalleryVideoBloc>()
                              .add(ChangeVolumeRequested());
                        },
                        icon: Icon(
                          state.videoPlayerController.value.volume == 0
                              ? Icons.volume_off
                              : Icons.volume_down,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
