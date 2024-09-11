import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/account_page/account_page.dart';
import 'package:talky_aplication_2/authentication_page/authentication_page.dart';
import 'package:talky_aplication_2/check_code_page.dart/check_code_page.dart';
import 'package:talky_aplication_2/home_page/home_page.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    EmailOTP.config(
      appName: 'Talky',
      otpType: OTPType.numeric,
      expiry: 30000,
      emailTheme: EmailTheme.v6,
      appEmail: 'dev.talky@gmail.com',
      otpLength: 4,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TalkyProvider(),
        )
      ],
      child: MaterialApp(
        home: const Scaffold(
          body: SplashPage(),
        ),
        initialRoute: '/',
        routes: {
          '/homePage': (context) => const HomePage(),
          '/authPage': (context) => const AuthenticationPage(),
          '/checkCodePage': (context) => const CheckCodePage(),
          '/AccountPage': (context) => const AccountPage(),
          '/SplashPage': (context) => const SplashPage(),
        },
      ),
    );
  }
}
