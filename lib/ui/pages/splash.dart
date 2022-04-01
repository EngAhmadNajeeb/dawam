import 'dart:async';
import 'package:dawam/ui/pages/homepage.dart';
import 'package:dawam/ui/pages/login_page.dart';
import 'package:dawam/utilities/app_colors.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double angle = 0;
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      angle += 0.01;
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 2), () async {
      await dataStore.loadAuthData().then((authData) {
        if (authData != null) {
          debugPrint("User Id ---------------------------> ${authData.user.id}");
          debugPrint("User email ---------------------------> ${authData.user.email}");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: AppColors.gradientColors,
              )),
              child: Center(
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Column(
                        children: [
                          Transform.rotate(
                            angle: angle,
                            child: Image.asset(
                              "assets/images/bg.png",
                              fit: BoxFit.fill,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.lobster(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'D',
                                  style: TextStyle(
                                    color: AppColors.red,
                                    fontSize: 45,
                                  ),
                                ),
                                TextSpan(text: 'a'),
                                TextSpan(
                                  text: 'w',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 216, 240, 0),
                                    fontSize: 40,
                                  ),
                                ),
                                TextSpan(text: 'am'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'developed by Eng.Ahmad Najeeb',
                        style: GoogleFonts.slabo27px(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: 0.07,
              child: Image.asset(
                "assets/images/bg.png",
                fit: BoxFit.fill,
                height: 400,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
