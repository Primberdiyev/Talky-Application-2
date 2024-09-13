import 'package:flutter/material.dart';
import 'package:talky_aplication_2/account_page/account_page.dart';
import 'package:talky_aplication_2/authentication_page/authentication_page.dart';
import 'package:talky_aplication_2/check_code_page.dart/check_code_page.dart';
import 'package:talky_aplication_2/input_mail_password_page/input_mail_password_page.dart.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/splash_page.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NameRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashPage());

    case NameRoutes.auth:
      return MaterialPageRoute(builder: (_) => const AuthenticationPage());
    case NameRoutes.checkCode:
      return MaterialPageRoute(builder: (_) => const CheckCodePage());
    case NameRoutes.inputMailPassword:
       return MaterialPageRoute(builder: (_)=>const InputMailPasswordPage());
  }

  return MaterialPageRoute(builder: (_) => const AccountPage());
}
