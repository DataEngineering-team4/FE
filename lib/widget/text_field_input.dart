import 'package:ai4005_fe/util/color.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String imageText;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    required this.imageText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      width: 325 * fem,
      height: 50 * fem,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff61418e), width: 3.0),
        color: const Color(0xff522f81),
        borderRadius: BorderRadius.circular(70 * fem),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 15 * fem,
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 28 * fem,
              height: 28 * fem,
              child: Image.asset(
                imageText,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 5 * fem,
          ),
          Flexible(
            flex: 3,
            child: TextField(
              controller: textEditingController,
              style: TextStyle(
                fontFamily: 'SUITE',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                color: mainTextColor,
              ),
              obscureText: isPass,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'SUITE',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w700,
                  color: subTextColor,
                ),
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
              ),
              keyboardType: textInputType,
            ),
          ),
        ],
      ),
    );
  }
}
