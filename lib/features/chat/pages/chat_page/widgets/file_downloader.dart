import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';

class FileDownloader {
  Future<String?> urlFileSaver({required String url, String? fileName}) async {
    try {
      final extension = url.split('.').last.split('?').first;
      final response = await http.get(Uri.parse(url));

      if (await Permission.storage.request().isGranted) {
        final directory = await getExternalStorageDirectory();

        if (directory == null) {
          throw ImportantTexts.unableStorage;
        }

        final filePath = '${directory.path}/$fileName.$extension';
        final file = File(filePath);
        await file.create(recursive: true);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        throw ImportantTexts.permissionNotGranted;
      }
    } catch (e) {
      rethrow;
    }
  }
}
