import 'package:dawam/main.dart';
import 'package:dawam/ui/pages/about_app.dart';
import 'package:dawam/ui/pages/all_recordings.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.trans("setting")),
        ),
        body: Column(
          children: [

            // InkWell(
            //   highlightColor: Colors.grey,
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const SalaryCalculator()),
            //     );
            //   },
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.calculate,
            //       color: Colors.grey[600],
            //       // color: AppConstants.lightAccent,
            //       size: 25,
            //     ),
            //     title: Text(
            //       AppLocalizations.of(context)!.trans("salary_calculator"),
            //       style: const TextStyle(fontSize: 18),
            //     ),
            //   ),
            // ),
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
            // InkWell(
            //   highlightColor: Colors.grey,
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const JobSettings()),
            //     );
            //   },
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.work,
            //       color: Colors.grey[600],
            //       size: 25,
            //     ),
            //     title: Text(
            //       AppLocalizations.of(context)!.trans("job_settings"),
            //       style: const TextStyle(fontSize: 18),
            //     ),
            //   ),
            // ),
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
          ],
        ),
      ),
    );
  }
}
