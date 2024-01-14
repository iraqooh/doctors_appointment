import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_appointment/pages/login_page.dart';
import 'package:doctors_appointment/pages/splash_screen.dart';
import 'package:doctors_appointment/pages/template.dart';
import 'package:doctors_appointment/utilities/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeProvider.instance.changeTheme(ThemeEnum.light);
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android
  );
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true
  );
  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'my_channel',
            channelName: 'Local Notification',
            channelDescription: 'Testing local notifications',
            channelGroupKey: 'channel_group'
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'channel_group',
            channelGroupName: 'Channel Group'
        )
      ]
  );
  bool isAllowedToSendNotifications =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider.instance,
        ),
      ],
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).currentThemeData,
          home: SplashScreen(),
        );
      },
    );
  }
}
