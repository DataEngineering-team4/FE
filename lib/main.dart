import 'package:ai4005_fe/presentation/login_screen.dart';
import 'package:ai4005_fe/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff411972),
      ),
      home: const LoginScreen(),
      // home: ChatScreen(
      //   audioRecorderController: AudioRecorderController(),
      // ),
    );
  }
}
