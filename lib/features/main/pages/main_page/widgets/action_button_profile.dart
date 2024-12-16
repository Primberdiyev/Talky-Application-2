import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/localization.dart';
import 'package:talky_aplication_2/core/localization/localization_provider.dart';
import 'package:talky_aplication_2/core/services/user_data_service.dart';
import 'package:talky_aplication_2/my_app.dart';
import 'package:talky_aplication_2/features/main/pages/chat_create/chat_create_page.dart';

class ActionButtonProfile extends StatelessWidget {
  const ActionButtonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final auth = UserDataService.instance.auth;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, bottom: 34),
          child: Consumer<LocalizationProvider>(builder: (
            context,
            provider,
            child,
          ) {
            return PopupMenuButton<String>(
              offset: const Offset(0, -100),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  child: SizedBox(
                    height: 25,
                    width: 70,
                    child: InkWell(
                      onTap: () async {
                        await auth.signOut();
                        if (context.mounted) {
                          MyApp.restartApp(context);
                        }
                      },
                      child: Text(locale.logOut),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  child: SizedBox(
                    height: 30,
                    width: 150,
                    child: InkWell(
                      onTap: () {
                        provider.setLocale();
                      },
                      child: Text(locale.langauge),
                    ),
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 34, right: 28),
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF377DFF),
            onPressed: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => const ChatCreatePage(),
              );
            },
            child: Image.asset(
              'assets/images/FloatingMenu.png',
              width: 40,
            ),
          ),
        ),
      ],
    );
  }
}
