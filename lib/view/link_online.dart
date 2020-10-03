import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pernikahan_lenda_riyanto/common/config.dart';
import 'package:url_launcher/url_launcher.dart';


class LinkOnline extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>  LayoutBuilder(
    builder: (_, constraints) {
      if (constraints.maxWidth >= kDesktopBreakpoint)
        return new _LinkOnlineDesktop();
      else return new _LinkOnlineMobile();
    },
  );
}

class _LinkOnlineMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            "res/images/online_link_background.jpg",
          ),
          fit: BoxFit.fill,
        )
    ),
    child: new ClipRect(
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5)
          ),
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                new Text(
                  "Zoom Online",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 48.0,
                  ),
                ),
                const SizedBox( height: 50, ),
                new FractionallySizedBox(
                  widthFactor: 0.8,
                  child: new RaisedButton(
                    child: const Text(
                      "Ikut Secara Online",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.black87,
                    padding: const EdgeInsets.all( 20.0 ),
                    onPressed: _navigateToWeddingOnline,
                  ),
                ),
                const SizedBox( height: 20, ),
                const SelectableText(
                  "Dengan passcode \"101020\" tanpa kutip",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox( height: 50, ),
                const Text(
                  "Atau isikan dengan informasi dibawah ini",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox( height: 20, ),
                const SelectableText(
                  "ID: 955 0130 1132",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox( height: 20.0, ),
                const SelectableText(
                  "Passcode: 101020",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox( height: 40.0, ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _LinkOnlineDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            "res/images/online_link_background.jpg",
          ),
          fit: BoxFit.fill,
        )
    ),
    child: new ClipRect(
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5)
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox( height: 10.0, ),
              new Text(
                "Zoom Online",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 48.0,
                ),
              ),
              const SizedBox( height: 50, ),
              new RaisedButton(
                child: const Text(
                  "Ikut Secara Online",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.black87,
                padding: const EdgeInsets.all( 20.0 ),
                onPressed: _navigateToWeddingOnline,
              ),
              const SizedBox( height: 20, ),
              const SelectableText(
                "Dengan passcode \"101020\" tanpa kutip",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox( height: 50, ),
              const Text(
                "Atau isikan dengan informasi dibawah ini",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox( height: 20, ),
              const SelectableText(
                "ID: 955 0130 1132",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox( height: 20.0, ),
              const SelectableText(
                "Passcode: 101020",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox( height: 40.0, ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _navigateToWeddingOnline() async {
  final onlineLiveUrl = "https://zoom.us/j/95501301132";
  if ( await canLaunch( onlineLiveUrl ) ) {
    launch( onlineLiveUrl );
  } else {
    Get.snackbar(
      null,
      "Tidak dapat membuka link",
      duration: const Duration( seconds: 3 ),
      isDismissible: true,
      colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
      backgroundColor: Theme.of( Get.context ).errorColor,
      icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
