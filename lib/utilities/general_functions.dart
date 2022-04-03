import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class GenFuns {
  static void launchWhatsApp({String phone = ""}) async {
    String url() {
      String iosUrl = "";
      String androidUrl = "";
      if (phone.isNotEmpty) {
        iosUrl = "whatsapp://wa.me/$phone";
        androidUrl = "whatsapp://send?phone=$phone";
      }
      if (Platform.isIOS) {
        return iosUrl;
      } else {
        return androidUrl;
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      await launch(
          "https://play.google.com/store/apps/details?id=com.whatsapp&hl=en&gl=US");
    }
  }

  static void launchLinkedInApp() async {
    String url() {
      String iosUrl = "linkedin://profile/ahmad-najeeb-8b9a21b5";
      String androidUrl = "linkedin://ahmad-najeeb-8b9a21b5";
      if (Platform.isIOS) {
        return iosUrl;
      } else {
        return androidUrl;
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      await launch("https://www.linkedin.com/in/ahmad-najeeb-8b9a21b5/");
    }
  }

  static void launchCallInApp() async {
    if (await canLaunch('tel:+963945400234')) {
      await launch('tel:+963945400234');
    } else {
      throw 'Could not launch tel:+963945400234';
    }
  }
}
