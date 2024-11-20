import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talky_aplication_2/my_app.dart';
import 'package:talky_aplication_2/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
