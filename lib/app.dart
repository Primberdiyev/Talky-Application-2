import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/app_routes.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

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
      child:  const MaterialApp(
        initialRoute: NameRoutes.splash,
        onGenerateRoute:generateRoute,
      ),
    );
  }
}
