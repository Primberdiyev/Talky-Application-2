import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/ui_kit/custom_user_avatar.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/group/pages/group_main_page/group_main_page.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:talky_aplication_2/utils/important_texts.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (
      context,
      provider,
      child,
    ) {
      return StreamBuilder(
        stream: provider.getAllGroupsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final List? allGroups = snapshot.data??[];
          return ListView.builder(
            itemCount: allGroups?.length,
            itemBuilder: (context, index) {
              final GroupModel? group = allGroups?[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupMainPage(
                        groupModel: group ?? {} as GroupModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 28,
                  ),
                  child: Row(
                    children: [
                      CustomUserAvatar(
                        avatarLink: group?.imgUrl ?? "",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group?.title ?? '',
                            style: const TextStyle(
                              color: Color(0xFF243443),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            ImportantTexts.lastMessage,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
