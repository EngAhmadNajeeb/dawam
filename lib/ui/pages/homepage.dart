import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:dawam/utilities/app_colors.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.trans("dawam")),
        ),
        backgroundColor: AppColors.pageBackground,
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => progressDialog.show(),
              child: const Text("Show"),
            ),
            ElevatedButton(
                onPressed: () => progressDialog.show(),
                child: const Text("Hide")),
          ],
        ));
  }
}
