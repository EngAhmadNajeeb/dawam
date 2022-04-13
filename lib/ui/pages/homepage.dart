import 'dart:math';
import 'package:dawam/blocs/current_month_bloc.dart';
import 'package:dawam/models/current_month.dart';
import 'package:dawam/ui/cards/current_month_card.dart';
import 'package:dawam/ui/cards/day_logs_card.dart';
import 'package:dawam/ui/pages/home_drawer.dart';
import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:dawam/utilities/app_colors.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrentMonthBloc bloc = CurrentMonthBloc();

  @override
  void initState() {
    bloc.getCurrentMonth(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
            dataStore.current = snapshot.data!.month;
            return Stack(
              children: [
                Column(
                  children: [
                    CurrentMonthCard(
                      key: Key("${Random().nextDouble()}"),
                      model: snapshot.data!,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.month.days.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              DayLogsCard(
                                day: snapshot.data!.month.days[index],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Visibility(
                      visible: snapshot.data!.lastEntryTody?.isInput ?? false,
                      child: InkWell(
                        onLongPress: () {
                          bloc.signInput(context, false);
                        },
                        child: FloatingActionButton.extended(
                          extendedTextStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          extendedIconLabelSpacing: 15,
                          extendedPadding: const EdgeInsets.all(25),
                          backgroundColor: Colors.red,
                          onPressed: () => Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!
                                .trans("long_press_to_output"),
                          ),
                          icon: const Icon(Icons.logout),
                          label: Text(
                              AppLocalizations.of(context)!.trans("output")),
                        ),
                      ),
                      replacement: InkWell(
                        onLongPress: () {
                          bloc.signInput(context, true);
                        },
                        child: FloatingActionButton.extended(
                          extendedTextStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          extendedIconLabelSpacing: 15,
                          extendedPadding: const EdgeInsets.all(25),
                          backgroundColor: Colors.green,
                          onPressed: () => Fluttertoast.showToast(
                            msg: AppLocalizations.of(context)!
                                .trans("long_press_to_input"),
                          ),
                          icon: const Icon(Icons.login),
                          label: Text(
                              AppLocalizations.of(context)!.trans("input")),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GeneralWidget.listProgressIndicator(),
          );
        },
      ),
      drawer: HomeDrawer(),
    );
  }
}
