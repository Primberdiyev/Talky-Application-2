import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/pages/chat_page/widgets/default_loading_image.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/main/pages/main_page/widgets/friends_list.dart';
import 'package:talky_aplication_2/features/main/providers/profile_page_provider.dart';

class ChatFilesTab extends StatelessWidget {
  const ChatFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfilePageProvider, ChatProvider>(
      builder: (
        context,
        provider,
        chatProvider,
        child,
      ) {
        return Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: 'Users'),
                    Tab(text: 'Files'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const FriendsList(),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: chatProvider.getImages(chatProvider.receiverUser?.id ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error loading images'),
                            );
                          }

                          final images = snapshot.data?.docs ?? [];
                          if (images.isEmpty) {
                            return const Center(
                              child: Text('No images shared'),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 37,
                              right: 36,
                              top: 41,
                            ),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                final imageUrl = images[index].data()['msg'] as String;
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width: 125,
                                    height: 125,
                                    fit: BoxFit.fill,
                                    imageBuilder: (context, imageProvider) => Image(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                    placeholder: (context, url) => const DefaultLoadingImage(),
                                    errorWidget: (
                                      context,
                                      url,
                                      error,
                                    ) =>
                                        const DefaultLoadingImage(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
