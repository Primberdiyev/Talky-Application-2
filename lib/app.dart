import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';
import 'package:talky_aplication_2/routes/app_routes.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TalkyProvider(),
        )
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
