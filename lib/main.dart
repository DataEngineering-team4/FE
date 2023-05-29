import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/chat_screen.dart';
import 'providers/user_provider.dart';
import 'view_model/audio_recorder_controller.dart';

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
      //home: const FirstScreen(),
      home: ChatScreen(
        audioRecorderController: AudioRecorderController(),
      ),
    );
  }
}
