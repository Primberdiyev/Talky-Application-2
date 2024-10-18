import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/widgets/file_downloader_file.dart';

class ChatFileProvider with ChangeNotifier {
  String? filePath;
  bool isLoading = false;
  bool isCompleted = false;

  changeLoading({bool? isNewCompleted}) {
    isLoading = !isLoading;

    if (isNewCompleted != null) {
      isCompleted = isNewCompleted;
    }
    notifyListeners();
  }

  Future openFileButton() async {
    await OpenFile.open(filePath);
  }

  Future downloadButton({required String url}) async {
    changeLoading();
    filePath = await FileDownloader().urlFileSaver(
      url: url,
      fileName: 'pdf_file',
    );
    changeLoading(isNewCompleted: true);

    if (filePath != null) {
      print('Fayl muvaffaqiyatli yuklandi: $filePath');
    } else {
      print('Yuklashda xatolik yuz berdi');
    }
  }
}
