import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zeus/core/constant/app_styles.dart';

 
Widget appBarWidget(
    {required String appBarTitle, TextStyle? style, double leftPadding = 0.0}) {
  return Container(
    height: kToolbarHeight, // Use standard AppBar height
    color: Colors.transparent, // Or set your desired background color
    child: Stack(
      children: [
        Positioned(
          top: 5.0, // Adjust this value to control the icon's vertical position

          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Center(
            // Center the title
            child: Text(
              appBarTitle,
              style: style ?? AppTextStyle.appBarTextStyle,
            ),
          ),
        ),
      ],
    ),
  );
}
