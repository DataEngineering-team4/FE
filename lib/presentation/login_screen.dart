import 'package:ai4005_fe/presentation/select_character_screen.dart';
import 'package:ai4005_fe/presentation/signup_screen.dart';
import 'package:ai4005_fe/resources/authentication_service.dart';
import 'package:ai4005_fe/util/color.dart';
import 'package:ai4005_fe/widget/text_field_input.dart';
import 'package:flutter/material.dart';

import '../util/util.dart';
import '../widget/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String response = await loginUser(
      username: _usernameController.text,
      password: _passwordController.text,
      context: context,
    );
    setState(() {
      _isLoading = false;
    });

    if (response == "success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => const SelectCharacterScreen())));
    } else {
      showSnackBar(response, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 209 * fem,
            ),
            Text(
              "로그인",
              style: TextStyle(
                fontFamily: 'SUITE',
                color: mainTextColor,
                fontSize: 32 * ffem,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 3 * fem,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "계정이 없으신가요?",
                  style: TextStyle(
                    fontFamily: 'SUITE',
                    color: subTextColor,
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 5 * fem,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignupScreen())));
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontFamily: 'SUITE',
                      color: interactiveTextColor,
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25 * fem),
            SizedBox(
              height: 20 * fem,
            ),
            TextFieldInput(
              imageText: 'assets/images/icons/user.png',
              textEditingController: _usernameController,
              hintText: '아이디',
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: 20 * fem,
            ),
            TextFieldInput(
              imageText: 'assets/images/icons/lock.png',
              textEditingController: _passwordController,
              hintText: '비밀번호',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            SizedBox(
              height: 40 * fem,
            ),
            GestureDetector(
              onTap: login,
              child: Button(
                width: 120 * fem,
                text: '로그인',
                isLoading: _isLoading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
