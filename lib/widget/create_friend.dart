import 'dart:typed_data';

import 'package:ai4005_fe/presentation/invitation_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../util/util.dart';

class CreateFriend extends StatefulWidget {
  const CreateFriend({super.key});

  @override
  State<CreateFriend> createState() => _CreateFriendState();
}

class _CreateFriendState extends State<CreateFriend> {
  Uint8List? image;

  Future getImage(ImageSource imageSource) async {
    image = await pickImage(imageSource);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () async {
        await getImage(ImageSource.gallery);
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => InvitationScreen(image: image!))));
      },
      child: SizedBox(
        width: 10 * fem,
        height: 10 * fem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5 * fem,
            ),
            Transform.translate(
              offset: Offset(-3 * fem, 0),
              child: SizedBox(
                  height: 115 * fem,
                  child: Image.asset(
                    'assets/images/icons/adding.png',
                    fit: BoxFit.fitHeight,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
