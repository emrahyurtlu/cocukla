import 'package:cocukla/screens/forget_password_screen.dart';
import 'package:cocukla/screens/home.dart';
import 'package:cocukla/screens/place_form.dart';
import 'package:cocukla/screens/my_places.dart';
import 'package:cocukla/screens/place_detail.dart';
import 'package:cocukla/screens/profile.dart';
import 'package:cocukla/screens/sign_in_screen.dart';
import 'package:cocukla/screens/sign_up_screen.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:cocukla/ui/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

import 'models/place_model.dart';

/*var model = PlaceModel(
    documentID: "1",
    name: "Kaşıbeyaz Ataşehir",
    city: "İstanbul",
    district: "Ataşehir",
    owner: "1",
    isFav: true,
    phone: "02122252244",
    rating: 4,
    email: "atasehir@kasiyeyaz.com",
    fax: "02125554411",
    digest:
        "Kaşıbeyaz restaurant 1980 yılında Gaziantep'te kurulmuştur. Kurulduğu günden beri kaliteden ödün vermeden hizmet sektöründe iş yaşamına devam etmiştir.",
    address: "Yeşiltepe Mah. Konyalı Sok. No:24 Ataşehir/İstanbul",
    comments: [
      {
        "image": "assets/images/avatar.png",
        "name": "Abdullah O.",
        "rating": 4,
        "content":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        "date": DateTime.now()
      },
      {
        "image": "assets/images/avatar.png",
        "name": "Mehmet S.",
        "rating": 5,
        "content":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
        "date": DateTime.now()
      },
      {
        "image": "assets/images/avatar.png",
        "name": "Bayram T.",
        "rating": 3,
        "content":
            "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        "date": DateTime.now()
      },
      {
        "image": "assets/images/avatar.png",
        "name": "Emrah Y.",
        "rating": 5,
        "content":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        "date": DateTime.now()
      },
    ],
    photos: [
      "assets/images/temp/kasibeyaz_atasehir.jpg",
      "assets/images/temp/gha_3325.jpg",
      "assets/images/temp/gha_3336.jpg",
      "assets/images/temp/gha_3499.jpg",
      "assets/images/temp/gha_3612.jpg",
    ],
    properties: [
      {
        "iconName": "access_time",
        "text": "10:00-00:00 arası hizmet vermektedir",
        "color": AppColor.green
      },
      {"iconName": "location_on", "text": "5.6km", "color": AppColor.dark_gray},
      {
        "iconName": "restaurant_menu",
        "text": "Çocuk menüsü",
        "color": AppColor.dark_gray
      },
      {
        "iconName": "child_friendly",
        "text": "Bebek bakım odası",
        "color": AppColor.dark_gray
      },
      {
        "iconName": "child_care",
        "text": "Oyun odası",
        "color": AppColor.dark_gray
      },
      {
        "iconName": "calendar_today",
        "text": "Randevu ile gidilir",
        "color": AppColor.dark_gray
      },
      {
        "iconName": "cake",
        "text": "Organizasyon yapılır",
        "color": AppColor.dark_gray
      },
    ]);*/

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
    //Original Code
    //DO NOT DELETE
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
      onClick: () => print("Waiting"),
      loaderColor: AppColor.pink,
    );
  }
}
