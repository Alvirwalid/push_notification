import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pushnotification/feature/views/bafsd/choose_login.dart';
import 'package:pushnotification/feature/views/chat_board.dart';

import 'package:pushnotification/feature/views/notification.dart';
import 'package:pushnotification/firebase_options.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   initializeDateFormatting().then((_) => runApp(const MyApp()));
}

Future<void>  _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ChooseLogin(),
    );
  }
}


  