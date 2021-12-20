import 'dart:io';
import 'package:face_detection_app/UI/screens/gallery_video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:path/path.dart' as path;

class DisplayGalleryMedia extends StatefulWidget {
  static const routeName = '/display-gallery-images';

  @override
  State<DisplayGalleryMedia> createState() => _DisplayGalleryMediaState();
}

class _DisplayGalleryMediaState extends State<DisplayGalleryMedia> {
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as List;
    List<Medium> media = arguments[0];
    String albumName = arguments[1];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: CarouselSlider.builder(
          itemCount: media.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1,
            enableInfiniteScroll: false,
          ),
          itemBuilder: (ctx, itemIndex, pageViewIndex) {
            return Stack(
              children: [
                if (media[itemIndex].mediumType == MediumType.image)
                  Positioned.fill(
                    child: Image(
                      fit: BoxFit.cover,
                      image: ThumbnailProvider(
                        mediumId: media[itemIndex].id,
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
                  ),
                if (media[itemIndex].mediumType == MediumType.video)
                  GalleryVideoPlayer(
                    media[itemIndex],
                    // Key("${media[itemIndex].hashCode}${media[itemIndex].creationDate}$pageViewIndex")
                  ),
              ],
            );
          }),
    );
  }
}
