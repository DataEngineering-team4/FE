import 'package:ai4005_fe/presentation/login_screen.dart';
import 'package:ai4005_fe/presentation/select_character_screen.dart';
import 'package:ai4005_fe/resources/authentication_service.dart';
import 'package:ai4005_fe/util/color.dart';
import 'package:ai4005_fe/widget/text_field_input.dart';
import 'package:flutter/material.dart';

import '../util/util.dart';
import '../widget/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void signup() async {
    setState(() {
      _isLoading = true;
    });

    String response = await signupUser(
      username: _usernameController.text,
      password: _passwordController.text,
      email: _emailController.text,
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
              "가입하기",
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
                  "이미 사용중인가요?",
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
                            builder: ((context) => const LoginScreen())));
                  },
                  child: Text(
                    "로그인",
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
              imageText: 'assets/images/icons/mail.png',
              textEditingController: _emailController,
              hintText: '이메일',
              textInputType: TextInputType.emailAddress,
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
              onTap: signup,
              child: Button(
                width: 120 * fem,
                text: '회원가입',
                isLoading: _isLoading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
