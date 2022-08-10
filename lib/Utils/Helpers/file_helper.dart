import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class FileHelper {
  static const String noteImageBase = 'notes';
  static Future<String?> saveImage(File image, String fileName) async {
    try {
      // Directory? _appPath = await getExternalStorageDirectory();
      // File _image = await File('${_appPath!.path}/$noteImageBase/$fileName.png')
      //     .create(recursive: true);
      Uint8List _bytes = image.readAsBytesSync();
      return base64Encode(_bytes);
    } catch (e) {}
    return null;
  }

  static Future<void> deleteImage(String path) async {
    await File(path).delete();
  }
}
