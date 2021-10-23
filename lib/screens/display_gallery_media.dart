import 'package:face_detection_app/screens/gallery_video_player.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DisplayGalleryMedia extends StatelessWidget {
  static const routeName = '/display-gallery-images';

  @override
  Widget build(BuildContext context) {
    var media = ModalRoute.of(context).settings.arguments as List<Medium>;
    return CarouselSlider.builder(
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
        });
  }
}
