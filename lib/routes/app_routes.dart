import 'package:flutter/material.dart';
import 'package:talky_aplication_2/features/auth/pages/authorization_page/authorization_page.dart';
import 'package:talky_aplication_2/features/auth/pages/check_code_page.dart/check_code_page.dart';
import 'package:talky_aplication_2/features/chat/chat_page/chat_page.dart';
import 'package:talky_aplication_2/features/group/pages/group_main_page.dart';
import 'package:talky_aplication_2/features/group/models/group_model.dart';
import 'package:talky_aplication_2/features/profile/pages/contacts_page/contacts_page.dart';
import 'package:talky_aplication_2/features/profile/pages/create_group_page/create_group_page.dart';
import 'package:talky_aplication_2/features/profile/pages/receiver_user_page.dart/receiver_user_page.dart';
import 'package:talky_aplication_2/features/profile/pages/set_profile/set_profile_page.dart';
import 'package:talky_aplication_2/features/auth/pages/forgot_password_page/forgot_password_page.dart';
import 'package:talky_aplication_2/features/auth/pages/input_mail_password_page/input_mail_password_page.dart.dart';
import 'package:talky_aplication_2/features/profile/pages/main_page/main_page.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/splash/pages/splash_page.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NameRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashPage());

    case NameRoutes.auth:
      return MaterialPageRoute(builder: (_) => const AuthorizationPage());
    case NameRoutes.checkCode:
      return MaterialPageRoute(builder: (_) => const CheckCodePage());
    case NameRoutes.inputMailPassword:
      return MaterialPageRoute(builder: (_) => const InputMailPasswordPage());
    case NameRoutes.forgotPassword:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
    case NameRoutes.main:
      return MaterialPageRoute(builder: (_) => const MainPage());
    case NameRoutes.contacts:
      return MaterialPageRoute(builder: (_) => const ContactsPage());
    case NameRoutes.chat:
      return MaterialPageRoute(
        builder: (_) => const ChatPage(),
      );
    case NameRoutes.group:
      final groupModel = settings.arguments as GroupModel;
      return MaterialPageRoute(
          builder: (_) => GroupMainPage(
                groupModel: groupModel,
              ));
    case NameRoutes.createGroup:
      return MaterialPageRoute(
        builder: (_) => CreateGroupPage(),
      );
    case NameRoutes.receiverUser:
      return MaterialPageRoute(
        builder: (_) => const ReceiverUserPage(),
      );
  }

  return MaterialPageRoute(builder: (_) => const SetProfilePage());
}
