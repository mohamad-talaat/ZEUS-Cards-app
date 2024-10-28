 
import 'package:flutter/material.dart';

import 'color.dart';

class AppFontWeight {
  static FontWeight thin = FontWeight.w100;
  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}

//PayPal Sans  it is normal reqular
//Montserrat   it is normal bold
class AppTextStyle {
  static TextStyle onBoardingTitle = TextStyle(
    fontFamily: "Montserrat",
    color: AppColor.primaryColor,
    fontWeight: AppFontWeight.bold,
    fontSize: 19,
    // decorationThickness: BorderSide.strokeAlignOutside
  );

  static TextStyle onBoardingdescription = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: AppFontWeight.extraLight,
      // height: 1.1.h,
      // fontWeight: FontWeight.w400,
      fontFamily: "PayPal Sans");

  static TextStyle appBarTextStyle = TextStyle(
    fontFamily: "Montserrat",
    color: AppColor.primaryColor,
    fontWeight: AppFontWeight.bold,
    fontSize: 20,
  );
  static TextStyle montserratSimiBold14White = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 14,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.white,
  );

  static TextStyle montserratSimiBold14WhiteForTransactionsButton =
   const TextStyle(
    fontFamily: "Montserrat",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
  );
  static TextStyle montserratSimiBold14BlackForLabelText =
    const TextStyle(
    fontFamily: "Montserrat",
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle montserratSimiBold14Black = const TextStyle(
    fontFamily: "Montserrat",//"assets/fonts/Montserrat-SemiBold.ttf",
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle montserratBold20 = const TextStyle(
      fontFamily: "Montserrat", fontSize: 18, fontWeight: FontWeight.bold);

  static TextStyle paypalRegular11 = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "PayPalSansSmall-Regular");

  static TextStyle paypalRegular14 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "PayPalSansSmall-Regular");

  static TextStyle successWordInmassegeInGetDialog = const TextStyle(
      color: AppColor.black,
      fontSize: 20,
      fontFamily: "Montserrat-SemiBold"); // Montserrat-SemiBold

  static TextStyle aBeeZeefont20boldblack = const TextStyle(
    fontFamily: "Montserrat",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle abyssinicaSilfont25boldblack = const TextStyle(
    fontFamily: "Montserrat",
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

 
}
