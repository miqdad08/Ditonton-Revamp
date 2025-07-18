import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xff2569ED);
Color secondaryColor = const Color(0xff8EBC39);
Color thirdColor = const Color(0xff61623A);
Color greyPrimaryColor = const Color(0xff494949);
Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff333333);
Color darkGreyColor = const Color(0xff767676);
Color greyColor = const Color(0xff747474);
Color greyTextColor = const Color(0xffB6B6B6);
Color lightGreyColor = const Color(0xffF4F4F4);
Color disableColor = const Color(0xffD9D9D9);
Color lightBackgroundColor = const Color(0xffFFFFFF);
Color darkBackgroundColor = const Color(0xff020518);
Color lightBlackColor = const Color(0xff4D4D4D);
Color blueColor = const Color(0xff125FD1);
Color textLinkColor = const Color(0xff4257C7);
Color skyBlueColor = const Color(0xffE8F1FF);
Color cyanColor = const Color(0xff19BAB6);
Color lightBlueColor = const Color(0xffE7EFFA);
Color purpleColor = const Color(0xff9747FF);
Color orangePrimaryColor = const Color(0xffE4A52B);
Color darkOrangeColor = const Color(0xffEF7728);
Color saffronColor = const Color(0xffFFA34E);
Color orangeColor = const Color(0xffFCFF72);
Color greenColor = const Color(0xff8DC63F);
Color greenSecondaryColor = const Color(0xffE6FFB7);
Color lightGreenColor = const Color(0xffD4EFDF);
Color numberBackgroundColor = const Color(0xff1A1D2E);
Color redColor = const Color(0xffFF2566);
Color errorColor = Colors.red[800]!;
Color redColorAccent = const Color(0xffF26250);
Color lightRedColor = const Color(0xffFADBD8);
Color darkBlueColor = const Color(0xff1B3D6C);
Color chocolateColor = const Color(0xff664738);
Color creamColor = const Color(0xffFEF8CC);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle blackTextStyleOpenSans = GoogleFonts.openSans(
  color: darkBackgroundColor,
);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);

TextStyle orangeTextStyle = GoogleFonts.poppins(
  color: orangePrimaryColor,
);

TextStyle primaryTextStyleOutfit = GoogleFonts.outfit(
  color: primaryColor,
);

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: darkBackgroundColor,
);

TextStyle lightGreyTextStyle = GoogleFonts.poppins(
  color: lightGreyColor,
);

TextStyle darkGreyTextStyle = GoogleFonts.poppins(
  color: darkGreyColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle whiteTextStyleOpenSans = GoogleFonts.openSans(
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: greyTextColor,
);

TextStyle blueTextStyle = GoogleFonts.poppins(
  color: blueColor,
);

TextStyle greenTextStyle = GoogleFonts.poppins(
  color: greenColor,
);

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarBrightness:
      color.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
      color.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light,
    ),
  );
}
