import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/general_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutApp extends StatelessWidget {
  final PackageInfo packageInfo;
  const AboutApp(this.packageInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.trans("about_app")),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.trans("dawam"),
                  style: GoogleFonts.slabo27px(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/logo4.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.trans('version'),
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  packageInfo.version,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .trans('developed_by_ahmad_najeeb'),
                  style: GoogleFonts.slabo27px(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        GenFuns.launchCallInApp();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.call, size: 30),
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        GenFuns.launchWhatsApp(phone: "+963945400234");
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/WhatsApp.png",
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        GenFuns.launchLinkedInApp();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/linkedin.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
