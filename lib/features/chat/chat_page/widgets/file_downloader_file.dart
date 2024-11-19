import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  Future<String?> urlFileSaver({required String url, String? fileName}) async {
    try {
      final extension = url.split('.').last.split('?').first;
      final response = await http.get(Uri.parse(url));
      if (await Permission.storage.request().isGranted) {
        final dir = Directory('/storage/emulated/0/Download');

        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        final filePath = '${dir.path}/$fileName.$extension';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        throw 'Storage permission not granted';
      }
    } catch (e) {
      rethrow;
    }
  }
}
