import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/ui/config/font_family.dart';
import 'package:cocukla/ui/screens/approval.dart';
import 'package:cocukla/ui/screens/forget_password_screen.dart';
import 'package:cocukla/ui/screens/home.dart';
import 'package:cocukla/ui/screens/my_places.dart';
import 'package:cocukla/ui/screens/place_detail.dart';
import 'package:cocukla/ui/screens/place_form.dart';
import 'package:cocukla/ui/screens/profile.dart';
import 'package:cocukla/ui/screens/sign_in_screen.dart';
import 'package:cocukla/ui/screens/sign_up_screen.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    home: CocuklaApp(),
    theme: ThemeData(
      primaryColor: AppColor.white,
      canvasColor: AppColor.light_gray,
      accentColor: AppColor.pink,
      fontFamily: "MontserratRegular",
    ),
    routes: {
      "/home": (context) => Home(),
      "/sign-in": (context) => SignInScreen(),
      "/sign-up": (context) => SignUpScreen(),
      "/forget-password": (context) => ForgetPasswordScreen(),
      "/product-detail": (context) => PlaceDetail(),
      "/my-profile": (context) => Profile(),
      "/my-places": (context) => Places(),
      "/add-place": (context) => PlaceForm(),
      "/approval": (context) => Approval(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class CocuklaApp extends StatefulWidget {
  @override
  _CocuklaAppState createState() => _CocuklaAppState();
}

class _CocuklaAppState extends State<CocuklaApp> {
  @override
  Widget build(BuildContext context) {
//    return SetPlaceRating();

    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: SignInScreen(),
      title: Text(
        'Hayatı Çocukla Yaşayın',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: FontFamily.Kristen),
      ),
      image: Image.asset('assets/images/cocukla_logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      onClick: () => redirectTo(context, SignInScreen()),
      loaderColor: AppColor.pink,
    );
  }
}
