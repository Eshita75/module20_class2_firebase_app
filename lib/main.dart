import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module20_class2_firebase_app/firebase_notification_service.dart';
import 'package:module20_class2_firebase_app/ui/firebase_notification.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'local_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await LocalNotifications.instance.initialize();
  await FirebaseNotification.instance.initialize();
  runApp(const TodoApp());
}
