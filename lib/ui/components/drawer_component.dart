import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocukla/business/login_service.dart';
import 'package:cocukla/ui/config/app_color.dart';
import 'package:cocukla/utilities/app_data.dart';
import 'package:cocukla/utilities/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatefulWidget {
  final FirebaseUser user;

  const DrawerComponent({Key key, this.user}) : super(key: key);

  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              (widget.user != null &&
                      widget.user.displayName != null &&
                      widget.user.displayName != "")
                  ? widget.user.displayName
                  : "Kullanıcı",
              style: TextStyle(color: AppColor.white),
            ),
            accountEmail: Text(widget.user != null ? widget.user.email : "",
                style: TextStyle(color: AppColor.white)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: CachedNetworkImage(
                imageUrl: widget.user != null && widget.user.photoUrl != null
                    ? widget.user.photoUrl
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
              Navigator.of(context).pushNamed("/my-places");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Çıkış"),
            onTap: () {
              if (AppData.user != null) logoutLog(AppData.user.email);
              FirebaseAuth.instance.signOut().then((_) {
                AppData.user = null;
                Navigator.of(context).pushNamed(CustomRoute.signIn);
              });
            },
          ),
        ],
      ),
    );
  }
}
