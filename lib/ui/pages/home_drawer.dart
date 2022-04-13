import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:dawam/main.dart';
import 'package:dawam/ui/pages/about_app.dart';
import 'package:dawam/ui/pages/all_recordings.dart';
import 'package:dawam/ui/pages/salary_calculator.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);
  final TextEditingController ipController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ipController.text = "192.168.1.1";
    return Drawer(
      child: Scaffold(
        body: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(dataStore.authData!.user.fullName),
              accountEmail: Text(dataStore.authData!.user.email),
              currentAccountPicture: Container(
                  margin: const EdgeInsets.all(7),
                  child: Hero(
                    tag: 'profilePic',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        imageUrl: "dataStore.user.picture",
                        errorWidget: (context, url, error) => const Image(
                          image: AssetImage(
                            'assets/images/man_placeholder.png',
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            InkWell(
              highlightColor: Colors.grey,
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllRecordings()),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.receipt_long_rounded,
                  color: Colors.grey[600],
                  // color: AppConstants.lightAccent,
                  size: 25,
                ),
                title: Text(
                  AppLocalizations.of(context)!.trans("all_recordings"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.grey,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalaryCalculator(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.calculate,
                  color: Colors.grey[600],
                  // color: AppConstants.lightAccent,
                  size: 25,
                ),
                title: Text(
                  AppLocalizations.of(context)!.trans("salary_calculator"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.grey,
              onTap: () {
                if (dataStore.lang == 'en') {
                  dataStore.setLang('ar').then((_) {
                    MyApp.changeLang(context);
                  });
                } else {
                  dataStore.setLang('en').then((_) {
                    MyApp.changeLang(context);
                  });
                }
              },
              child: ListTile(
                leading: Icon(
                  Icons.language,
                  color: Colors.grey[600],
                  // color: AppConstants.lightAccent,
                  size: 25,
                ),
                title: Text(
                  AppLocalizations.of(context)!.trans("language"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.grey,
              onTap: () {
                PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AboutApp(packageInfo);
                  }));
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.perm_device_information,
                  color: Colors.grey[600],
                  size: 25,
                ),
                title: Text(
                  AppLocalizations.of(context)!.trans("about_app"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Card(
              child: TextField(
                controller: ipController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                onSubmitted: (str) {
                  dataStore.baseUrl = str + ":8080";
                  MyApp.restartApp(context);
                },
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
