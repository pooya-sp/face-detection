import 'package:photo_gallery/photo_gallery.dart';

class Gallery {
  Future<Map<String, List<Medium>>> getAllMedia() async {
    final images = await PhotoGallery.listAlbums(mediumType: MediumType.image);
    final videos = await PhotoGallery.listAlbums(mediumType: MediumType.video);
    final imageAlbum = images.where((album) => album.name == "All").toList();
    final videoAlbum = videos.where((album) => album.name == "All").toList();
    final MediaPage imagePage = await imageAlbum[0].listMedia();
    final MediaPage videoPage = await videoAlbum[0].listMedia();
    final List<Medium> items = [
      ...imagePage.items.reversed.toList(),
      ...videoPage.items.reversed.toList(),
    ];
    final Map<String, List<Medium>> allMedia = {};
    allMedia["All"] = items;
    allMedia["Images"] = imagePage.items.reversed.toList();
    allMedia["Videos"] = videoPage.items.reversed.toList();
    return allMedia;
  }

  Future<Map<String, List<Medium>>> getMedia(MediumType? mediumType) async {
    final images = await PhotoGallery.listAlbums(mediumType: mediumType!);
    Map<String, List<Medium>> allMedia = {};
    for (Album image in images) {
      final imagePage = await image.listMedia();
      allMedia[image.name] = (imagePage.items.reversed.toList());
    }
    return allMedia;
  }
}
