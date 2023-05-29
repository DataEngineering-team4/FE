import 'dart:convert';

import 'package:ai4005_fe/util/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../util/color.dart';
import '../view_model/audio_recorder_controller.dart';
import '../widget/button.dart';
import '../widget/create_friend.dart';
import '../widget/friend.dart';
import 'chat_screen.dart';

class SelectCharacterScreen extends StatefulWidget {
  const SelectCharacterScreen({super.key});

  @override
  State<SelectCharacterScreen> createState() => _SelectCharacterScreenState();
}

class _SelectCharacterScreenState extends State<SelectCharacterScreen> {
  int selected_index = -1;
  bool _loading = true;

  late List<Map> friends;

  void getFriends() async {
    final uid = Provider.of<UserProvider>(context, listen: false).getUser.uid;
    final response = await http.get(
      Uri.parse('http://www.det4.site:5000/drawing/?user_id=$uid'),
      headers: {'Content-Type': 'application/json'},
    );

    var data = json.decode(utf8.decode(response.bodyBytes)) as List;

    setState(() {
      friends = data.map((item) => item as Map).toList();
      friends.sort((a, b) => a['id'].compareTo(b['id']));
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriends();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Center(
        child: _loading
            ? const CircularProgressIndicator(
                color: mainTextColor,
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    Text(
                      '나의 캐릭터',
                      style: TextStyle(
                        fontFamily: 'SUITE',
                        fontSize: 32 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.2575 * ffem / fem,
                        color: mainTextColor,
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0, // Horizontal spacing
                            mainAxisSpacing: 1.0, // Vertical spacing
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (index < friends.length) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (friends[index]['status'] != "pending") {
                                      selected_index = index;
                                    }
                                  });
                                },
                                child: Friend(
                                  is_selected:
                                      index == selected_index ? true : false,
                                  image_link: friends[index]['link'],
                                  friend_name: friends[index]['name'],
                                  status: friends[index]['status'],
                                ),
                              );
                            } else {
                              return const CreateFriend();
                            }
                          }),
                    ),
                    Container(
                      height: 20 * fem,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (selected_index == -1) {
                            showSnackBar("친구를 골라 주세요.", context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      charName: friends[selected_index]['name'],
                                      drawingNumber: friends[selected_index]
                                          ['id'],
                                      audioRecorderController:
                                          AudioRecorderController()),
                                ));
                          }
                        },
                        child: Button(
                          width: baseWidth * 7 / 8,
                          text: '선택 완료',
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
