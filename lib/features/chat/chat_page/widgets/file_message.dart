import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/chat_page/widgets/get_name_from_url.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_file_provider.dart';
import 'package:talky_aplication_2/unilities/app_colors.dart';

class FileMessage extends StatelessWidget {
  final bool isMine;
  final link;
  const FileMessage({super.key, required this.isMine, required this.link});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatFileProvider(),
      child:
          Consumer<ChatFileProvider>(builder: (context, fileProvider, child) {
        return ListTile(
          title: Align(
            alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: 80,
              width: 240,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMine ? AppColors.primaryBlue : AppColors.chatColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        image: (!fileProvider.state.isLoading) &&
                                !fileProvider.state.isCompleted
                            ? const DecorationImage(
                                image: AssetImage(
                                    'assets/images/download_file.png'),
                              )
                            : null,
                        color:
                            !fileProvider.state.isLoading ? Colors.white : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: fileProvider.state.isLoading
                        ? const Center(
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                )),
                          )
                        : InkWell(
                            onTap: () => fileProvider.state.isCompleted
                                ? fileProvider.openFileButton()
                                : fileProvider.downloadButton(url: link),
                          ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      GetNameFromUrl().getFileNameFromUrl(
                        link,
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
