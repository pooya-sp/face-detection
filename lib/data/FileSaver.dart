import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileSaver {
  static Future saveFileToStorage(XFile xfile) async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      Directory? directory = await getExternalStorageDirectory();
      final fileName = basename(xfile.path);
      File imageFile = File(xfile.path);
      imageFile.copy('${directory!.path}/$fileName');
    }
  }
}
