import 'package:ai4005_fe/presentation/login_screen.dart';
import 'package:ai4005_fe/presentation/signup_screen.dart';
import 'package:ai4005_fe/util/color.dart';
import 'package:flutter/material.dart';

import '../widget/button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20 * fem),
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 10 * fem,
                      child: Transform.translate(
                        offset: Offset(-7 * fem, -19 * fem),
                        child: Container(
                          width: 30 * fem,
                          height: 30 * fem,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffb52673),
                          ),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 6 * fem,
                      child: Transform.translate(
                        offset: Offset(-12 * fem, 14 * fem),
                        child: Container(
                          width: 30 * fem,
                          height: 30 * fem,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff5fb155),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "이미 계정이 있으신가요?",
                      style: TextStyle(
                        fontFamily: 'SUITE',
                        color: subTextColor,
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 8 * fem,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginScreen())));
                      },
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          fontFamily: 'SUITE',
                          color: interactiveTextColor,
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform.scale(
                    scale: 7.5 * fem,
                    child: Transform.translate(
                      offset: Offset(4 * fem, 18 * fem),
                      child: Container(
                        width: 30 * fem,
                        height: 30 * fem,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffa855dd),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160 * fem,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20 * fem,
                    bottom: 15 * fem,
                  ),
                  height: 155 * fem,
                  child:
                      Image.asset("assets/images/characters/start_screen.png"),
                ),
                Text(
                  "안녕하세요! 이 세상에 하나뿐인 친구를 만나볼까요?",
                  style: TextStyle(
                    fontFamily: 'SUITE',
                    fontSize: 28 * ffem,
                    fontWeight: FontWeight.w700,
                    color: mainTextColor,
                  ),
                ),
                SizedBox(
                  height: 10 * fem,
                ),
                Text(
                  "우선 회원 가입부터 진행해봐요",
                  style: TextStyle(
                    fontFamily: 'SUITE',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w700,
                    color: subTextColor,
                  ),
                ),
                SizedBox(
                  height: 80 * fem,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SignupScreen())));
                    },
                    child: Button(
                      text: "시작하기",
                      width: baseWidth * 7 / 8,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
