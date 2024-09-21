import 'package:flutter/material.dart';
import 'package:talky_aplication_2/edit_profile_page/edit_profile_page.dart';
import 'package:talky_aplication_2/authorization_page/authorization_page.dart';
import 'package:talky_aplication_2/check_code_page.dart/check_code_page.dart';
import 'package:talky_aplication_2/forgot_password_page/forgot_password_page.dart';
import 'package:talky_aplication_2/input_mail_password_page/input_mail_password_page.dart.dart';
import 'package:talky_aplication_2/online_users_page/online_users_page.dart';
import 'package:talky_aplication_2/profile_page/profile_page.dart';
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
  }

  return MaterialPageRoute(builder: (_) => const EditProfilePage());
}
