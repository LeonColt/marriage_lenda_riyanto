import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pernikahan_lenda_riyanto/view/countdown.dart';
import 'package:pernikahan_lenda_riyanto/view/location.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put( new CountDownController(), permanent: true );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lenda & Riyanto',
      initialBinding: new InitialBinding(),
      theme: ThemeData(
        primaryColor: const Color( 0XFFEA6292 ),
        primaryColorLight: const Color( 0XFFF88FB0 ),
        primaryColorDark: const Color( 0XFFB01455 ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Pasifico",
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => new Scaffold(
    body: new ListView(
      children: [
        new Countdown(),
        new Location(),
        const SizedBox( height: 10.0, ),
        new Center(
          child: const Text(
            "🄯 Copyleft Lenda & Riyanto. License GPLV3",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox( height: 10.0, ),
        new Center(
          child: new FlatButton(
            child: const Text(
              "Source Code",
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              final url = "https://github.com/LeonColt/marriage_lenda_riyanto";
              if ( await canLaunch( url ) ) {
                launch( url );
              } else {
                Get.snackbar(
                  null,
                  "Tidak dapat membuka halaman source code.",
                  duration: const Duration( seconds: 3 ),
                  isDismissible: true,
                  colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
                  backgroundColor: Theme.of( Get.context ).errorColor,
                  icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ),
        const SizedBox( height: 10.0, ),
        new Center(
          child: new FlatButton(
            child: const Text(
              "Kontribusi Gambar Ayam",
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              final url = "https://lovepik.com/images/png-animal.html";
              if ( await canLaunch( url ) ) {
                launch( url );
              } else {
                Get.snackbar(
                  null,
                  "Tidak dapat membuka link.",
                  duration: const Duration( seconds: 3 ),
                  isDismissible: true,
                  colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
                  backgroundColor: Theme.of( Get.context ).errorColor,
                  icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ),
        new Center(
          child: new FlatButton(
            child: const Text(
              "Kontribusi Background",
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              final url = "https://wallpaperaccess.com/japanese-roses";
              if ( await canLaunch( url ) ) {
                launch( url );
              } else {
                Get.snackbar(
                  null,
                  "Tidak dapat membuka link.",
                  duration: const Duration( seconds: 3 ),
                  isDismissible: true,
                  colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
                  backgroundColor: Theme.of( Get.context ).errorColor,
                  icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        )
      ],
    ),
  );
}
