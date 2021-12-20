import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/gallery_folder_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/gallery_folder_bloc/states/gallery_folder_states.dart';
import 'package:face_detection_app/data/bottom_sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

class GalleryFolders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryFolderBloc, GalleryFolderState>(
        builder: (context, state) {
      if (state is FolderIsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is FoldersLoadingComplete) {
        return GridView.builder(
            itemCount: state.media.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (ctx, index) {
              try {
                final mediumId = state.media.values.toList()[index].first.id;
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () {
                      showGalleryPictures(ctx, state.media.keys.toList()[index],
                          state.media.values.toList()[index]);
                    },
                    child: Column(
                      children: [
                        // if (state.media.length == 0)
                        //   Expanded(
                        //     child: Image(
                        //         fit: BoxFit.cover,
                        //         image: AlbumThumbnailProvider(
                        //           albumId: state.albums[index].id,
                        //           mediumType: state.albums[index].mediumType,
                        //           highQuality: true,
                        //         )),
                        //   ),
                        Expanded(
                            child: Image(
                                fit: BoxFit.cover,
                                image: ThumbnailProvider(
                                  mediumId: mediumId,
                                  highQuality: true,
                                ),
                                errorBuilder: (ctx, exception, stackTrace) =>
                                    Center(child: Icon(Icons.error)))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 60,
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '${state.media.keys.toList()[index]}',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '(${state.media.values.toList()[index].length})',
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } catch (error) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.error),
                    Text("No images found."),
                  ],
                );
              }
            });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
