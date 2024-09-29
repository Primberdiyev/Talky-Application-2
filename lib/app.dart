import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/auth/providers/auth_google_provider.dart';
import 'package:talky_aplication_2/auth/providers/otp_provider.dart';
import 'package:talky_aplication_2/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/app_routes.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthGoogleProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePageProvider()),
        ChangeNotifierProvider(create: (_) => SignInAndUpProvider()),
        ChangeNotifierProvider(create: (_) => ValueStateProvider()),
      ],
      child: MaterialApp(
        initialRoute: NameRoutes.splash,
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
