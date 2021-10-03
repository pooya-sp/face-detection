import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DisplayGalleryImages extends StatefulWidget {
  static const routeName = '/display-gallery-images';

  @override
  State<DisplayGalleryImages> createState() => _DisplayGalleryImagesState();
}

class _DisplayGalleryImagesState extends State<DisplayGalleryImages> {
 
  @override
  Widget build(BuildContext context) {
    var media = ModalRoute.of(context)!.settings.arguments as List<Medium>;
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
              Positioned.fill(
                child: Image(
                    fit: BoxFit.cover,
                    image: ThumbnailProvider(
                      mediumId: media[itemIndex].id,
                      highQuality: true,
                    )),
              ),
              if (media[itemIndex].mediumType == MediumType.video)
                GestureDetector(
                  onTap: () {
                  },
                  child: Center(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(360)),
                    ),
                  ),
                )
            ],
          );
        });
    // Stack(
    //   children: [
    //     PhotoViewGallery.builder(
    //         itemCount: media.length,
    //         builder: (ctx, index) {
    //           _mediaIndex = index;
    //           return PhotoViewGalleryPageOptions(
    //               imageProvider: ThumbnailProvider(
    //             mediumId: media[index].id,
    //             highQuality: true,
    //           ));
    //         }),
    //     _showVideoIcon(media[_mediaIndex]),
    //   ],
    // );
  }
}
