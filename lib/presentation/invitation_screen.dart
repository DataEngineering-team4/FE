import 'dart:convert';

import 'package:ai4005_fe/util/color.dart';
import 'package:ai4005_fe/widget/text_field_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../util/util.dart';
import '../widget/button.dart';

class InvitationScreen extends StatefulWidget {
  Uint8List image;
  InvitationScreen({
    required this.image,
    super.key,
  });

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  final TextEditingController _friendNameController = TextEditingController();
  late Uint8List image;
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = widget.image;
  }

  Future getImage(ImageSource imageSource) async {
    Uint8List im = await pickImage(imageSource);
    setState(() {
      image = im;
    });
  }

  void invite() async {
    print(Provider.of<UserProvider>(context, listen: false).getUser.uid);
    print(Provider.of<UserProvider>(context, listen: false).getUser.username);

    setState(() {
      _isloading = true;
    });
    final response =
        await http.post(Uri.parse('http://www.det4.site:5000/user/drawing/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "file": image,
              "name": _friendNameController.text,
              "user_id":
                  Provider.of<UserProvider>(context, listen: false).getUser.uid,
            }));

    setState(() {
      _isloading = false;
    });

    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 310 * fem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 70 * fem,
              ),
              SizedBox(
                width: 175 * fem,
                child: Image.asset(
                  "assets/images/characters/invitation.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 25 * fem,
              ),
              Text(
                "새로운 친구를 초대했어요",
                style: TextStyle(
                  fontFamily: 'SUITE',
                  color: mainTextColor,
                  fontSize: 32 * ffem,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5 * fem,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '당신이 그린 그림이 새로운 친구로 만들어졌어요. 새로운 친구와 이야기 꽃을 피워보세요',
                  style: TextStyle(
                    fontFamily: 'SUITE',
                    color: subTextColor,
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 5 * fem,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '새로운 친구가 도착하는 데 최대 24시간이 소요됩니다',
                  style: TextStyle(
                    fontFamily: 'SUITE',
                    color: interactiveTextColor,
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 15 * fem,
              ),
              TextFieldInput(
                textEditingController: _friendNameController,
                hintText: "새로운 친구의 이름",
                textInputType: TextInputType.text,
                imageText: 'assets/images/icons/user.png',
              ),
              SizedBox(
                height: 20 * fem,
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 250 * fem,
                  ),
                  padding: EdgeInsets.all(0 * fem),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 10.0,
                      color: const Color(0xff61418e),
                    ),
                    borderRadius: BorderRadius.circular(20 * fem),
                    color: const Color(0xff61418e),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10 * fem),
                    child: image == null
                        ? widget.image != null
                            ? Image(
                                image: MemoryImage(widget.image),
                                fit: BoxFit.cover,
                              )
                            : const Image(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwVLdSDmgrZN7TkzbHJb8dD0_7ASUQuERL2A&usqp=CAU'),
                              )
                        : Image(
                            image: MemoryImage(image),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 30 * fem,
              ),
              GestureDetector(
                onTap: invite,
                child: Button(
                  width: 120 * fem,
                  text: '완료',
                  isLoading: _isloading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
