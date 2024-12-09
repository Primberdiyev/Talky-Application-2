import 'package:open_file/open_file.dart';
import 'package:talky_aplication_2/core/base/base_change_notifier.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/file_downloader.dart';
import 'package:talky_aplication_2/utils/statuses.dart';

class ChatFileProvider extends BaseChangeNotifier {
  String? filePath;

  Future openFileButton() async {
    await OpenFile.open(filePath);
  }

  Future downloadButton({required String url}) async {
    updateState(Statuses.loading);
    filePath = await FileDownloader().urlFileSaver(
      url: url,
      fileName: 'pdf_file',
    );

    if (filePath != null) {
      updateState(Statuses.completed);
      return filePath;
    } else {
      updateState(Statuses.error);
      return null;
    }
  }
}
