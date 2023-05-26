import 'package:ai4005_fe/presentation/chat_screen.dart';
import 'package:ai4005_fe/util/color.dart';
import 'package:ai4005_fe/widget/friend.dart';
import 'package:flutter/material.dart';

import '../view_model/audio_recorder_controller.dart';
import '../widget/button.dart';
import '../widget/create_friend.dart';

class SelectCharacterScreen extends StatefulWidget {
  const SelectCharacterScreen({super.key});

  @override
  State<SelectCharacterScreen> createState() => _SelectCharacterScreenState();
}

class _SelectCharacterScreenState extends State<SelectCharacterScreen> {
  int selected_index = -1;

  final List<Map> friends = [
    const {
      'image_name': 'temp_yellow.png',
      'friend_name': '귀여운 노랑이',
      'is_made': true,
    },
    const {
      'image_name': 'temp_main.png',
      'friend_name': '귀여운 졸라맨',
      'is_made': true,
    },
    const {
      'image_name': 'temp_muscle.png',
      'friend_name': '근육 짱짱맨',
      'is_made': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150 * fem,
            ),
            SizedBox(
              // download31NJa (26:127)
              width: 139 * fem,
              height: 106 * fem,
              child: Image.asset(
                'assets/images/characters/select_character.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 17 * fem,
            ),
            Material(
              type: MaterialType.transparency,
              child: Text(
                '나의 캐릭터',
                style: TextStyle(
                  fontFamily: 'SUITE',
                  fontSize: 32 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2575 * ffem / fem,
                  color: mainTextColor,
                ),
              ),
            ),
            SizedBox(
              height: 25 * fem,
            ),
            SizedBox(
              width: 330 * fem,
              height: 330 * fem,
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: friends.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0, // Horizontal spacing
                    mainAxisSpacing: 1.0, // Vertical spacing
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < friends.length) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (friends[index]['is_made'] == true) {
                              selected_index = index;
                            }
                          });
                        },
                        child: Friend(
                          is_selected: index == selected_index ? true : false,
                          image_name: friends[index]['image_name'],
                          friend_name: friends[index]['friend_name'],
                          is_made: friends[index]['is_made'],
                        ),
                      );
                    } else {
                      return const CreateFriend();
                    }
                  }),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            audioRecorderController: AudioRecorderController()),
                      ));
                },
                child: Button(
                  width: baseWidth * 7 / 8,
                  text: '선택 완료',
                )),
          ],
        ),
      ),
    );
  }
}
