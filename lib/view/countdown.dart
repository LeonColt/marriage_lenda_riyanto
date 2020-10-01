import 'dart:async';
import 'dart:ui';

import 'package:count_by_clock/count_by_clock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pernikahan_lenda_riyanto/common/config.dart';

class Countdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>  LayoutBuilder(
    builder: (_, constraints) {
      if (constraints.maxWidth >= kDesktopBreakpoint)
        return new _CountdownDesktop();
      else return new _CountdownMobile();
    },
  );
}

class _CountdownMobile extends GetView<CountDownController> {

  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage(
          "res/images/home_page_background.jpg",
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
          child: new FractionallySizedBox(
            widthFactor: 0.9,
            child: new ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox( height: 10.0, ),
                new Text(
                  "Lenda & Riyanto",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 48.0,
                  ),
                ),
                const SizedBox( height: 10.0, ),
                new AspectRatio(
                  aspectRatio: 5/2,
                  child: new Image.asset(
                    "res/images/rooster_hen_love.png",
                  ),
                ),
                const SizedBox( height: 10.0, ),
                const Text(
                  "Akan melakukan pernikahan pada 10 Oktober 2020",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox( height: 20.0, ),
                const Text(
                  "Dari pukul 13:00 WIB sampai 16:00 WIB",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox( height: 20.0, ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Obx(
                          () => new _Count(
                            count: controller.days,
                            description: "Hari",
                          ),
                    ),
                    const SizedBox( width: 10, ),
                    new Obx(
                          () => new _Count(
                            count: controller.hours,
                            description: "Jam",
                          ),
                    ),
                  ],
                ),
                const SizedBox( height: 10, ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Obx(
                          () => new _Count( count: controller.minutes, description: "Menit", ),
                    ),
                    const SizedBox( width: 10, ),
                    new Obx(
                          () => new _Count( count: controller.seconds, description: "Detik", ),
                    ),
                  ],
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

class _CountdownDesktop extends GetView<CountDownController> {

  @override
  Widget build(BuildContext context) => new Container(
    decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            "res/images/home_page_background.jpg",
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
                "Lenda & Riyanto",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 48.0,
                ),
              ),
              const SizedBox( height: 20.0, ),
              new AspectRatio(
                aspectRatio: 4/1,
                child: new Image.asset(
                  "res/images/rooster_hen_love.png",
                ),
              ),
              const SizedBox( height: 10.0, ),
              const Text(
                "Akan melakukan pernikahan pada 10 Oktober 2020",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox( height: 20.0, ),
              const Text(
                "Dari pukul 13:00 WIB sampai 16:00 WIB",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox( height: 20.0, ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Obx(
                        () => new _Count(
                          count: controller.days,
                          description: "Hari",
                          clockArea: 28,
                          tickThickness: 8,
                        ),
                  ),
                  const SizedBox( width: 20, ),
                  new Obx(
                        () => new _Count(
                          count: controller.hours,
                          description: "Jam",
                          clockArea: 28,
                          tickThickness: 8,
                        ),
                  ),
                  const SizedBox( width: 20, ),
                  new Obx(
                        () => new _Count(
                          count: controller.minutes,
                          description: "Menit",
                          clockArea: 28,
                          tickThickness: 8,
                        ),
                  ),
                  const SizedBox( width: 20, ),
                  new Obx(
                        () => new _Count(
                          count: controller.seconds,
                          description: "Detik",
                          clockArea: 28,
                          tickThickness: 8,
                        ),
                  ),
                ],
              ),
              const SizedBox( height: 40, ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Count extends StatelessWidget {

  final int count;
  final double clockArea, tickThickness;
  final String description;

  const _Count({Key key, this.count, this.description, this.clockArea = 18, this.tickThickness,}) : super(key: key);

  @override
  Widget build(BuildContext context) => new Card(
    elevation: CARD_ELEVATION,
    child: new Padding(
      padding: const EdgeInsets.all( 10.0 ),
      child: new Column(
        children: [
          new CountByClock(
            count,
            digitCount: 2,
            tickColor: Colors.white,
            baseColor: Theme.of(context).primaryColor,
            clockArea: clockArea,
            tickThickness: tickThickness,
            flatStyle: false,
            curve: Curves.elasticOut,
            hideTick: true,
          ),
          const SizedBox( height: 10.0, ),
          new Text(
            description,
            style: new TextStyle(
              color: Theme.of( context ).primaryColorDark,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
          )
        ],
      ),
    ),
  );
}

class CountDownController extends GetxController {
  Timer _timer;
  final Rx<Duration> duration = new Rx<Duration>( weddingDate.difference( DateTime.now() ) );

  int get days => duration.value.inDays;
  int get hours => duration.value.inHours % 24;
  int get minutes => duration.value.inMinutes % 60;
  int get seconds => duration.value.inSeconds % 60;

  @override
  void onInit() {
    duration.value = weddingDate.difference( DateTime.now() );
    _timer = new Timer.periodic( const Duration( seconds: 1 ), ( Timer timer ) {
      if ( duration.value.inSeconds > 0 ) {
        duration.value = weddingDate.difference( DateTime.now() );
      } else {

      }
    });
    super.onInit();
  }

  @override
  FutureOr onClose() async {
    _timer.cancel();
    super.onClose();
  }
}
