import 'package:audioplayers/audioplayers.dart';
import 'package:copapp/Controller/Service/ProductInfoService.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  static double value = 0;
  List<int> numbers = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    update();

    ProductInfoService().GetTotalScore().then((v) {
      value = v;

      setValue();
    });
  }

  void setValue() {
    numbers = [];
    if (value > 0) {
      int t = value.toInt();
      while (t > 0) {
        int r = t % 10;
        numbers.add(r);
        t = t ~/ 10;
      }
    } else {
      value = 0;
      numbers = [0, 0, 0, 0, 0];
    }
    isLoading = false;
    update();
  }

  void add(double d, bool playSound) {
    isLoading = true;
    update();
    if (playSound)
      AudioCache(
        prefix: 'assets/audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
      ).play('coin.mp3');
    value += d;
    setValue();
  }

  void decrease(double d) {
    isLoading = true;
    update();
    value -= d;
    setValue();
  }

  getValue() {
    return value;
  }
}
