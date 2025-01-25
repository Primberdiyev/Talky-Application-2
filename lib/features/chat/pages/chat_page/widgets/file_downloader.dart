import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  Future<String?> urlFileSaver({required String url, String? fileName}) async {
    try {
      final extension = url.split('.').last.split('?').first;
      final response = await http.get(Uri.parse(url));

      if (Platform.isAndroid) {
        if (!await Permission.storage.request().isGranted) {
          throw 'Storage permission not granted';
        }
      } else {
        if (!await Permission.manageExternalStorage.request().isGranted) {
       //   throw 'Storage permission not granted';
        }
      }

      final directory = Platform.isAndroid
          ? (await getExternalStorageDirectories(
              type: StorageDirectory.downloads,
            ))
              ?.first
          : await getApplicationDocumentsDirectory();

      if (directory == null) {
        throw 'Storage directory not found';
      }

      final filePath = '${directory.path}/$fileName.$extension';
      final file = File(filePath);

      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);

      return filePath;
    } catch (e) {
      rethrow;
    }
  }
}
