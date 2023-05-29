import 'dart:convert';

import 'package:ai4005_fe/view_model/audio_recorder_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import "../object/message.dart";
import '../providers/user_provider.dart';
import '../util/color.dart';

class ChatScreen extends StatefulWidget {
  final AudioRecorderController audioRecorderController;
  final int drawingNumber;
  final String charName;
  const ChatScreen({
    required this.charName,
    required this.audioRecorderController,
    required this.drawingNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://www.det4.site:5000/talk/admin/'),
  );
  bool _isRecording = false;
  bool _ableRecording = true;
  static bool _talkingAI = false;
  Map<String, String> animationLinks = {};
  String aiText = "";

  final player = AudioPlayer();
  final playlist = [];

  void playNextAudio() async {
    print(playlist);
    if (playlist.isNotEmpty) {
      print("HERE!");
      // If there are any URLs in the queue...
      await player.setUrl(playlist.removeAt(0));
      await player.play(); // Start playing.
      await player.pause();
    }
  }

  void listen() async {
    channel.stream.listen((message) async {
      Response response = Response.toResponse(message);
      if (response.isInputText()) {
        print('DO SOMETHING FOR INPUT TEXT');
        print(response.content);
      } else if (response.isAudioUrl()) {
        print('TALKING AI To TRUE');
        playlist.add(response.content);
        print(player.playing);
        if (!player.playing) {
          playNextAudio();
        }
      } else if (response.isOutputText()) {
        print('DO SOMETHING FOR OUTPUT TEXT');
        print(response.content);
        setState(() {
          aiText += " ${response.content}";
        });
      } else if (response.isFinish()) {
        print('TALKING AI To FALSE');
        setState(() {
          _talkingAI = false;
          _ableRecording = true;
        });
      } else {
        print('FUCKIND ELSE!');
      }
    });
  }

  void getGif() async {
    final uid = Provider.of<UserProvider>(context, listen: false).getUser.uid;
    final drawingId = widget.drawingNumber;
    print(uid);
    print(drawingId);
    final response = await http.get(
      Uri.parse(
          'http://www.det4.site:5000/animation/?user_id=$uid&drawing_id=$drawingId'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    for (var item in jsonResponse) {
      animationLinks[item['purpose']] = item['link'];
    }
    print("what'sgoing on");
    setState() {}

    print(animationLinks['talking1']);
    print(animationLinks['listen1']);
    print(animationLinks['wait1']);
  }

  @override
  void initState() {
    super.initState();
    getGif();
    listen();
    player.playerStateStream.listen((state) {
      if (state.playing) {}
      switch (state.processingState) {
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
          playNextAudio();
          break;
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _onRecordButtonPressed() async {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      await widget.audioRecorderController.startRecording();
    } else {
      setState(() {
        _ableRecording = false;
      });
      String? filePath = await widget.audioRecorderController.stopRecording();
      if (filePath != null) {
        widget.audioRecorderController.sendAudioData(channel, filePath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Transform.scale(
              scale: 12 * fem,
              child: Transform.translate(
                offset: Offset(8 * fem, 10 * fem),
                child: Image.asset(
                  'assets/images/characters/chat_screen.png',
                  width: 15 * fem,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15 * fem),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 65 * fem,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 9 * fem),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10 * fem,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        widget.charName,
                                        style: TextStyle(
                                          fontFamily: 'SUITE',
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: mainTextColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20 * fem),
                                    Text(
                                      '>',
                                      style: TextStyle(
                                        fontFamily: 'SUITE',
                                        fontSize: 24 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575 * ffem / fem,
                                        color: mainTextColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 32 * fem,
                                      height: 32 * fem,
                                      child: Image.asset(
                                        'assets/images/icons/notification.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8 * fem,
                                    ),
                                    SizedBox(
                                      width: 31 * fem,
                                      height: 31 * fem,
                                      child: Image.asset(
                                        'assets/images/icons/setting.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3 * fem,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 133 * fem,
                                    height: 2 * fem,
                                    decoration: const BoxDecoration(
                                      color: subTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3 * fem),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '다른 캐릭터와 대화 해보세요',
                                      style: TextStyle(
                                        fontFamily: 'SUITE',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575 * ffem / fem,
                                        color: subTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35 * fem),
                          Stack(
                            children: [
                              Container(
                                height: 370 * fem,
                                decoration: BoxDecoration(
                                  color: const Color(0xff5a2f86),
                                  borderRadius: BorderRadius.circular(40 * fem),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -60 * fem),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: 332 * fem,
                                      height: 120 * fem,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: const [0.3, 0.8],
                                          colors: _isRecording
                                              ? [
                                                  const Color.fromRGBO(
                                                      107, 204, 120, 0.8),
                                                  const Color.fromRGBO(
                                                      107, 204, 120, 0),
                                                ]
                                              : _ableRecording
                                                  ? [
                                                      const Color.fromRGBO(
                                                          170, 51, 109, 0.8),
                                                      const Color.fromRGBO(
                                                          170, 51, 109, 0)
                                                    ]
                                                  : [
                                                      const Color.fromRGBO(
                                                          72, 72, 72, 0.8),
                                                      const Color.fromRGBO(
                                                          72, 72, 72, 0)
                                                    ],
                                        ),
                                      )),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, 19 * fem),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.all(15 * fem),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(40 * fem),
                                    ),
                                    width: 332 * fem,
                                    height: 332 * fem,
                                    child: _talkingAI
                                        ? Image.network(
                                            animationLinks['talking1'] ??
                                                "https://media.tenor.com/ped8-MGZjJMAAAAC/loading-slow-internet.gif",
                                            fit: BoxFit.cover,
                                          )
                                        : _ableRecording
                                            ? Image.network(
                                                animationLinks['wait1'] ??
                                                    "https://media.tenor.com/ped8-MGZjJMAAAAC/loading-slow-internet.gif",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                animationLinks['listen1'] ??
                                                    "https://media.tenor.com/ped8-MGZjJMAAAAC/loading-slow-internet.gif",
                                                fit: BoxFit.fitHeight,
                                              ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20 * fem,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight: 160 * fem,
                            ),
                            width: 360 * fem,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12 * fem,
                              vertical: 13 * fem,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 15 * fem,
                                color: const Color(0xff5a2f86),
                              ),
                              borderRadius: BorderRadius.circular(40 * fem),
                              color: Colors.white,
                            ),
                            child: Text(
                              aiText,
                              style: TextStyle(
                                fontFamily: 'SUITE',
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15 * fem,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_ableRecording) {
                                _onRecordButtonPressed();
                              }
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 68 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfffefdff)),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  // rectangle9aKp (26:109)
                                  child: _isRecording
                                      ? SizedBox(
                                          width: 33 * fem,
                                          height: 33 * fem,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xffdce670),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 55 * fem,
                                          height: 55 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _ableRecording
                                                  ? const Color(0xffb92771)
                                                  : const Color(0xff727272),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
