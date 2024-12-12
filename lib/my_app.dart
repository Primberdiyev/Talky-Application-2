import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/core/localization/generated/localization.dart';
import 'package:talky_aplication_2/core/localization/localization_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/otp_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/sign_in_and_up_provider.dart';
import 'package:talky_aplication_2/features/auth/providers/value_state_provider.dart';
import 'package:talky_aplication_2/features/chat/providers/chat_provider.dart';
import 'package:talky_aplication_2/features/main/providers/all_users_provider.dart';
import 'package:talky_aplication_2/features/main/providers/group_provider.dart';
import 'package:talky_aplication_2/features/main/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/features/main/providers/user_provider.dart';
import 'package:talky_aplication_2/routes/app_routes.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void restartApp(BuildContext context) {
    final state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    if (mounted) {
      setState(() {
        key = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePageProvider()),
        ChangeNotifierProvider(create: (_) => SignInAndUpProvider()),
        ChangeNotifierProvider(create: (_) => ValueStateProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => AllUsersProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: KeyedSubtree(
        key: key,
        child: Consumer<LocalizationProvider>(builder: (
          context,
          provider,
          child,
        ) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: NameRoutes.splash,
            onGenerateRoute: generateRoute,
            theme: ThemeData(
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: const Color(0xFFE5E5E5),
            ),
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            locale: provider.currentLocale,
          );
        }),
      ),
    );
  }
}
