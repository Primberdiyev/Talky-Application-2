import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talky_aplication_2/routes/name_routes.dart';
import 'package:talky_aplication_2/splash/providers/splash_provider.dart';
import 'package:talky_aplication_2/unilities/profile_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff377DFF),
      body: ChangeNotifierProvider(
        create: (context) => SplashProvider()..getProfileState(),
        child: Consumer<SplashProvider>(
          builder: (context, value, child) {
            if (value.state.isCompleted || value.state.isError) {
              String route = NameRoutes.auth;
              if (value.profileState == ProfileState.completed) {
                route = NameRoutes.auth;
              } else if (value.profileState == ProfileState.create) {
                route = NameRoutes.auth;
              }
              Future.delayed(
                Duration.zero,
                () => {
                  Navigator.pushReplacementNamed(
                    context,
                    route,
                  )
                },
              );
            }
            return const Center(
              child: Center(
                child: Text(
                  'Talky',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
