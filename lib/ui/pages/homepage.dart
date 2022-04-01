import 'package:dawam/blocs/current_month_bloc.dart';
import 'package:dawam/models/current_month.dart';
import 'package:dawam/ui/cards/current_month_card.dart';
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
  CurrentMonthBloc bloc = CurrentMonthBloc();
  @override
  void initState() {
    controller = ScrollController();
    bloc.getCurrentMonth(context);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.trans("dawam")),
      ),
      backgroundColor: AppColors.pageBackground,
      body: StreamBuilder<CurrentMonth>(
        stream: bloc.currentMonthStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CurrentMonthCard(model: snapshot.data!);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GeneralWidget.listProgressIndicator(),
          );
        },
      ),
    );
  }
}
