import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/models/property_model.dart';
import 'package:cocukla/screens/product_detail.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/attribute.dart';

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
    ProductModel model = ProductModel(
        id: "1",
        title: "Kaşıbeyaz Ataşehir",
        city: "İstanbul",
        district: "Ataşehir",
        editor_id: "1",
        isFav: true,
        phone_number: "02122252244",
        rating: 4,
        email: "atasehir@kasiyeyaz.com",
        fax: "02125554411",
        text:
            "Kaşıbeyaz restaurant 1980 yılında Gaziantep'te kurulmuştur. Kurulduğu günden beri kaliteden ödün vermeden hizmet sektöründe iş yaşamına devam etmiştir.",
        address: "Yeşiltepe Mah. Konyalı Sok. No:24 Ataşehir/İstanbul",
        comments: null,
        photos: null,
        properties: [
          PropertyModel(turn: 1, icon: Icon(Icons.access_time), text: "Açık"),
          PropertyModel(turn: 2, icon: Icon(Icons.location_on), text: "5.6km"),
          PropertyModel(turn: 3, icon: Icon(Icons.restaurant_menu), text: "Çocuk menüsü"),
          PropertyModel(turn: 4, icon: Icon(Icons.child_friendly), text: "Bebek bakım odası"),
          PropertyModel(turn: 5, icon: Icon(Icons.child_care), text: "Oyun odası"),
        ]);
    return ProductDetail(model);
//    return Home();

    //Original Code
    //DO NOT DELETE
    /*return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: SignInScreen(),
      title: Text(
        'Hayatı Çocukla Yaşayın',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: "Kristen"),
      ),
      image: Image.asset('assets/images/cocukla_logo.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Waiting"),
      loaderColor: AppColor.pink,
    );*/
  }
}
