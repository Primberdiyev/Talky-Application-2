import 'package:flutter/material.dart';
import 'package:talky_aplication_2/auth/pages/authorization_page/authorization_page.dart';
import 'package:talky_aplication_2/auth/pages/check_code_page.dart/check_code_page.dart';
import 'package:talky_aplication_2/profile/pages/chat_page/chat_page.dart';
import 'package:talky_aplication_2/profile/pages/receiver_user_page.dart/receiver_user_page.dart';
import 'package:talky_aplication_2/profile/pages/set_profile/set_profile_page.dart';
import 'package:talky_aplication_2/auth/pages/forgot_password_page/forgot_password_page.dart';
import 'package:talky_aplication_2/auth/pages/input_mail_password_page/input_mail_password_page.dart.dart';
import 'package:talky_aplication_2/profile/pages/online_users_page/online_users_page.dart';
import 'package:talky_aplication_2/profile/pages/profile_page/profile_page.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/splash_page.dart';

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
    case NameRoutes.profile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case NameRoutes.onlinUsers:
      return MaterialPageRoute(builder: (_) => const OnlineUsersPage());
    case NameRoutes.chat:
      return MaterialPageRoute(
        builder: (_) => const ChatPage(),
      );
    case NameRoutes.receiverUser:
      return MaterialPageRoute(
        builder: (_) => const ReceiverUserPage(),
      );
  }

  return MaterialPageRoute(builder: (_) => const SetProfilePage());
}
