import 'package:face_detection_app/business_logic/Blocs/gallery_bloc/events/gallery_events.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_bloc/gallery_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_bloc/states/gallery_states.dart';
import 'package:face_detection_app/screens/display_gallery_media.dart';
import 'package:face_detection_app/screens/gallery/real_size_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sizer/sizer.dart';

class GalleryWidget extends StatefulWidget {
  final List<Medium> album;
  final String albumName;
  GalleryWidget(this.albumName, this.album);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  List<Medium> selectedPhotos = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GalleryBloc>(context, listen: false)
        .add(GalleryInitializeRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Text(
              widget.albumName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              ' (${widget.album.length})',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ])),
      BlocBuilder<GalleryBloc, GalleryState>(builder: (context, state) {
        if (state is GalleryLoadingComplete) {
          return Stack(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: GridView.builder(
                    itemCount: widget.album.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, index) {
                      return Stack(children: [
                        Positioned.fill(
                            child: GestureDetector(
                                onTap: () async {
                                  final bool result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RealSizeMedia(
                                              widget.album[index],
                                              selectedPhotos.contains(
                                                  widget.album[index]))));

                                  if (selectedPhotos
                                          .contains(widget.album[index]) &&
                                      !result) {
                                    selectedPhotos.remove(widget.album[index]);
                                  }
                                  if (!selectedPhotos
                                          .contains(widget.album[index]) &&
                                      result) {
                                    selectedPhotos.add(widget.album[index]);
                                  }
                                  BlocProvider.of<GalleryBloc>(context,
                                          listen: false)
                                      .add(ItemSelected());
                                },
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: ThumbnailProvider(
                                    mediumId: widget.album[index].id,
                                    mediumType: widget.album[index].mediumType,
                                    highQuality: true,
                                  ),
                                  errorBuilder: (ctx, exception, stackTrace) =>
                                      Center(child: Icon(Icons.error)),
                                ))),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Container(
                                    width: 6.w,
                                    height: 4.h,
                                    child: Transform.scale(
                                        scale: 1.25,
                                        child: Checkbox(
                                            shape: CircleBorder(),
                                            value: selectedPhotos
                                                .contains(widget.album[index]),
                                            onChanged: (_) {
                                              if (selectedPhotos.contains(
                                                  widget.album[index])) {
                                                selectedPhotos.remove(
                                                    widget.album[index]);
                                              } else {
                                                selectedPhotos
                                                    .add(widget.album[index]);
                                              }
                                              BlocProvider.of<GalleryBloc>(
                                                      context,
                                                      listen: false)
                                                  .add(ItemSelected());
                                            }))))),
                        if (widget.album[index].mediumType == MediumType.video)
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 4, bottom: 4),
                                  child: Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                  )))
                      ]);
                    })),
            Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          fixedSize: Size.fromHeight(8.h)),
                      onPressed: () {
                        if (selectedPhotos.length > 0) {
                          Navigator.of(context).pushReplacementNamed(
                              DisplayGalleryMedia.routeName,
                              arguments: selectedPhotos);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(widget.album.first.mediumType ==
                                    MediumType.image
                                ? "Please select some photos"
                                : "Please select some videos"),
                          ));
                        }
                      },
                      child: Icon(Icons.arrow_right_alt)),
                )),
            Positioned(
                bottom: 3,
                right: 9,
                child: Container(
                    width: 5.w,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle),
                    child: Text(
                      '${selectedPhotos.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )))
          ]);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })
    ]);
  }
}
