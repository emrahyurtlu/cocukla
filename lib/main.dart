import 'package:cocukla/models/comment_model.dart';
import 'package:cocukla/models/photo_model.dart';
import 'package:cocukla/models/product_model.dart';
import 'package:cocukla/models/property_model.dart';
import 'package:cocukla/screens/component_test.dart';
import 'package:cocukla/screens/product_detail.dart';
import 'package:cocukla/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    var model = ProductModel(
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
        comments: [
          CommentModel(
              imageLink: "assets/images/avatar.png",
              name: "Abdullah OSKAY",
              rating: 4,
              text:
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
              date: DateTime.now()),
          CommentModel(
              imageLink: "assets/images/avatar.png",
              name: "Mehmet SARAÇ",
              rating: 5,
              text:
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
              date: DateTime.now()),
          CommentModel(
              imageLink: "assets/images/avatar.png",
              name: "Bayram TUNÇBİLEK",
              rating: 3,
              text:
                  "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
              date: DateTime.now()),
          CommentModel(
              imageLink: "assets/images/avatar.png",
              name: "Emrah YURTLU",
              rating: 5,
              text:
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
              date: DateTime.now()),
        ],
        photos: [
          PhotoModel(imageLink: "assets/images/temp/kasibeyaz_atasehir.jpg"),
          PhotoModel(imageLink: "assets/images/temp/gha_3325.jpg"),
          PhotoModel(imageLink: "assets/images/temp/gha_3336.jpg"),
          PhotoModel(imageLink: "assets/images/temp/gha_3499.jpg"),
          PhotoModel(imageLink: "assets/images/temp/gha_3612.jpg"),
        ],
        properties: [
          PropertyModel(
              icon_name: "access_time",
              text: "10:00-00:00 arası hizmet vermektedir",
              color: AppColor.green),
          PropertyModel(
              icon_name: "location_on",
              text: "5.6km",
              color: AppColor.dark_gray),
          PropertyModel(
              icon_name: "restaurant_menu",
              text: "Çocuk menüsü",
              color: AppColor.dark_gray),
          PropertyModel(
              icon_name: "child_friendly",
              text: "Bebek bakım odası",
              color: AppColor.dark_gray),
          PropertyModel(
              icon_name: "child_care",
              text: "Oyun odası",
              color: AppColor.dark_gray),
          PropertyModel(
              icon_name: "calendar_today",
              text: "Randevu ile gidilir",
              color: AppColor.dark_gray),
          PropertyModel(
              icon_name: "cake",
              text: "Organizasyon yapılır",
              color: AppColor.dark_gray),
        ]);
    return ProductDetail(model);
//    return Home();
//  return ComponentTest();

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
