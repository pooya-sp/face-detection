import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_gallery/photo_gallery.dart';

class Gallery {
  Future<Map<String, List<AssetEntity>>> getAlbumMedia(
      List<AssetPathEntity> albums) async {
    Map<String, List<AssetEntity>> media = {};
    for (AssetPathEntity album in albums) {
      await album
          .getAssetListRange(start: 0, end: 5000)
          .then((value) => media[album.name] = value);
    }
    return media;
  }

  // Future<Map<String, Map<AssetEntity, Uint8List?>>> getImages(
  //     Map<String, List<AssetEntity>> albums) async {
  //   Map<String, Map<AssetEntity, Uint8List?>> imageAlbums = {};
  //   Map<AssetEntity, Uint8List?> media = {};
  //   for (var albumName in albums.keys) {
  //     for (var photo in albums[albumName]!) {
  //       if (photo.type == AssetType.image) {
  //         final value = await photo.thumbDataWithSize(400, 200);
  //         media[photo] = value;
  //       }
  //     }
  //     if (media.length > 0) {
  //       imageAlbums[albumName] = media;
  //     }
  //     media = {};
  //   }
  //   return imageAlbums;
  // }

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
