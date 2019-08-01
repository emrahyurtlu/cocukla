import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/models/user_model.dart';
import 'package:cocukla/ui/components/conditional_component.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  UserModel user = AppData.user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              (user != null && user.name != null && user.name != "")
                  ? user.name
                  : "Kullanıcı",
              style: TextStyle(color: AppColor.white),
            ),
            accountEmail: Text(user != null ? user.email : "",
                style: TextStyle(color: AppColor.white)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: CachedNetworkImage(
                imageUrl: user != null && user.image != null
                    ? user.image
                    : "assets/images/user.png",
                width: 86,
                height: 86,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
              radius: 50,
              backgroundColor: AppColor.light_gray,
            ),
            decoration: BoxDecoration(color: AppColor.pink),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text("Profilim"),
            onTap: () {
              Navigator.of(context).pushNamed("/my-profile");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.place),
            title: Text("Mekanlarım"),
            onTap: () {
              Navigator.of(context).pushNamed(CustomRoute.myPlaces);
            },
          ),
          ConditionalComponent(
            condition: AppData.user?.isAuthorized,
            children: <Widget>[
              Divider(),
              ListTile(
                leading: Icon(Icons.gavel),
                title: Text("Onay Bekleyenler"),
                onTap: () {
                  Navigator.of(context).pushNamed(CustomRoute.approval);
                },
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Çıkış"),
            onTap: () {
              if (AppData.user != null) logoutLog(AppData.user.email);
              //signOut();
              Navigator.of(context).pop();
              redirectToRoute(context, CustomRoute.signIn);
            },
          ),
        ],
      ),
    );
  }
}
