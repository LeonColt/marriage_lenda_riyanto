import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as locationService;
import 'package:pernikahan_lenda_riyanto/common/config.dart';
import 'package:url_launcher/url_launcher.dart';


class Location extends StatelessWidget {
  final ui.VoidCallback onNextPressed, onPreviousPressed;

  const Location({Key key, this.onNextPressed, this.onPreviousPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  LayoutBuilder(
    builder: (_, constraints) {
      if (constraints.maxWidth >= kDesktopBreakpoint)
        return new _LocationDesktop( onNextPressed, onPreviousPressed );
      else return new _LocationMobile( onNextPressed, onPreviousPressed );
    },
  );
}

class _LocationMobile extends StatelessWidget {
  final ui.VoidCallback onNextPressed, onPreviousPressed;

  _LocationMobile(this.onNextPressed, this.onPreviousPressed);
  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            "res/images/location_background.jpg",
          ),
          fit: BoxFit.fill,
        )
    ),
    child: new ClipRect(
      child: new BackdropFilter(
        filter: new ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5)
          ),
          child: new ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              new Text(
                "Lokasi",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 48.0,
                ),
              ),
              const SizedBox( height: 20.0, ),
              new FractionallySizedBox(
                widthFactor: 0.8,
                child: new SizedBox(
                  height: 400,
                  child: _getMap(),
                ),
              ),
              const SizedBox( height: 20, ),
              new FractionallySizedBox(
                widthFactor: 0.8,
                child: new RaisedButton(
                  child: const Text(
                    "Tunjukkan Arah",
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.black87,
                  padding: const EdgeInsets.all( 20.0 ),
                  onPressed: _navigateToWeddingLocation,
                ),
              ),
              const SizedBox( height: 20, ),
              const Text(
                "Atau scan QR Code dibawah ini",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox( height: 20, ),
              new SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                child: new Image.asset(
                  "res/images/location_qr_code.png",
                ),
              ),
              const SizedBox( height: 40.0, ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _LocationDesktop extends StatelessWidget {
  final ui.VoidCallback onNextPressed, onPreviousPressed;

  _LocationDesktop(this.onNextPressed, this.onPreviousPressed);
  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            "res/images/location_background.jpg",
          ),
          fit: BoxFit.fill,
        )
    ),
    child: new ClipRect(
      child: new BackdropFilter(
        filter: new ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5)
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox( height: 10.0, ),
              const Text(
                "Lokasi",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 48.0,
                ),
              ),
              const SizedBox( height: 20.0, ),
              new SizedBox(
                height: 500,
                width: 700,
                child: _getMap(),
              ),
              const SizedBox( height: 20, ),
              new RaisedButton(
                child: const Text(
                  "Tunjukkan Arah",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.black87,
                padding: const EdgeInsets.all( 20.0 ),
                onPressed: _navigateToWeddingLocation,
              ),
              const SizedBox( height: 20, ),
              const Text(
                "Atau scan QR Code dibawah ini",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox( height: 20, ),
              new Image.asset(
                "res/images/location_qr_code.png",
                height: MIN_WIDTH,
                width: MIN_WIDTH,
              ),
              const SizedBox( height: 40, ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _navigateToWeddingLocation() async {
  final location = new locationService.Location();

  bool _serviceEnabled;
  locationService.PermissionStatus _permissionGranted;
  locationService.LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == locationService.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != locationService.PermissionStatus.granted) {
      Get.snackbar(
        null,
        "Tidak dapat mendapatkan lokasi anda untuk menunjukkan arah.",
        duration: const Duration( seconds: 3 ),
        isDismissible: true,
        colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
        backgroundColor: Theme.of( Get.context ).errorColor,
        icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  _locationData = await location.getLocation();

  final navigationUrl = "http://maps.google.com/maps?saddr=${ _locationData.latitude },${ _locationData.longitude }&daddr=-2.109506,106.101734";
  if ( await canLaunch( navigationUrl ) ) {
    launch( navigationUrl );
  } else {
    Get.snackbar(
      null,
      "Tidak dapat membuka peta",
      duration: const Duration( seconds: 3 ),
      isDismissible: true,
      colorText: Theme.of( Get.context ).primaryTextTheme.headline6.color,
      backgroundColor: Theme.of( Get.context ).errorColor,
      icon: new Icon( Icons.error, color: Theme.of( Get.context ).primaryTextTheme.headline6.color, ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

Widget _getMap() {
  String htmlId = "wedding-location";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
      htmlId,
      (int viewId) => IFrameElement()
        ..width = '600'
        ..height = '450'
        ..src = "https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3987.1120626891166!2d106.10362025978435!3d-2.11042630965308!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e22c11ae6ec1043%3A0xc8e7882803b6e975!2sVihara%20SHEN%20TE!5e0!3m2!1sen!2sid!4v1601484942941!5m2!1sen!2sid"
        ..style.border = '0'
        ..allowFullscreen = false
        ..tabIndex = 0,
  );

  return HtmlElementView(viewType: htmlId);
}
