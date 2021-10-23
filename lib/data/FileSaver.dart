import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileSaver {
  static Future saveFileToStorage(XFile xfile) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      Directory directory = await getExternalStorageDirectory();
      String newPath = '';
      // /storage/emulated/0/Android/data/com.example.face_detection_app/files
      List<String> folders = directory.path.split('/');
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != "Android") {
          newPath += '/' + folder;
        } else {
          break;
        }
      }
      final fileName = basename(xfile.path);
      // xfile.saveTo('$fileName');
      newPath = newPath + "/FaceApp";
      directory = Directory(newPath);
      print(directory.path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        xfile.saveTo(directory.path + '/$fileName');
        print("file saved");
        // File saveFile = File(directory.path + '/$fileName');
      }
    }
  }
}
