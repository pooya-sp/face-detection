import 'package:face_detection_app/screens/gallery_video_player.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sizer/sizer.dart';

class RealSizeMedia extends StatefulWidget {
  final Medium medium;
  bool isSelected;

  RealSizeMedia(this.medium, this.isSelected);

  @override
  State<RealSizeMedia> createState() => _RealSizeMediaState();
}

class _RealSizeMediaState extends State<RealSizeMedia> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(widget.isSelected);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Transform.scale(
              scale: 1.75,
              child: Checkbox(
                  side: BorderSide(width: 1.25),
                  shape: CircleBorder(),
                  value: widget.isSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.isSelected = value;
                    });
                  }),
            ),
          ],
        ),
        body: widget.medium.mediumType == MediumType.image
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isSelected = !widget.isSelected;
                  });
                },
                child: Image(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: ThumbnailProvider(
                    mediumId: widget.medium.id,
                    highQuality: true,
                  ),
                  errorBuilder: (ctx, exception, stackTrace) => Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 80,
                      ),
                      Text('Failed to load image'),
                    ],
                  )),
                ),
              )
            : GalleryVideoPlayer(widget.medium),
      ),
    );
  }
}
