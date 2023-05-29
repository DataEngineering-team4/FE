import 'package:flutter/material.dart';

import '../util/color.dart';

class Friend extends StatefulWidget {
  final String image_link;
  final String friend_name;
  final String status;
  final bool is_selected;

  const Friend({
    required this.image_link,
    required this.friend_name,
    required this.status,
    required this.is_selected,
    Key? key,
  }) : super(key: key);

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 120 * fem,
            height: 120 * fem,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * fem),
                ),
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 120 * fem,
                height: 120 * fem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10 * fem),
                  child: Image.network(
                    widget
                        .image_link, // Use the image_link property from the widget
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                      opacity: widget.is_selected ? 1 : 0,
                      child: Transform.scale(
                        scale: 1.2,
                        child: Transform.translate(
                          offset: const Offset(10, -10),
                          child: Container(
                              width: 30 * fem,
                              height: 30 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xff61418e),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xff522f81), width: 3),
                              ),
                              child: Transform.translate(
                                offset: const Offset(0, 3),
                                child: Image.asset(
                                  "assets/images/icons/checkmark.png",
                                  width: 1 * fem,
                                ),
                              )),
                        ),
                      )),
                  SizedBox(
                    width: 2 * fem,
                  ),
                ],
              ),
              Center(
                  child: Opacity(
                      opacity: widget.status == "active" ? 0 : 0.7,
                      child: Container(
                        width: 110 * fem,
                        height: 110 * fem,
                        color: Colors.black,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '생성중',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SUITE',
                              fontSize: 30 * fem,
                              fontWeight: FontWeight.w900,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ))),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15 * fem),
              Expanded(
                child: Center(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      widget
                          .friend_name, // Use the friend_name property from the widget
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SUITE',
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w700,
                        height: 2.3 / fem, // Divide by fem instead of ffem
                        color: friendTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print('delete');
                  });
                },
                child: Container(
                  width: 15 * fem,
                  height: 15 * fem,
                  margin: EdgeInsets.only(right: 1 * fem),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/icons/delete.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    print("edit");
                  });
                },
                child: Container(
                  width: 15 * fem,
                  height: 15 * fem,
                  margin: EdgeInsets.only(right: 25 * fem),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/icons/edit.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
