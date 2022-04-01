import 'dart:async';
import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:dawam/models/current_month.dart';

class CurrentMonthCard extends StatefulWidget {
  final CurrentMonth model;
  CurrentMonthCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final _CurrentMonthCardState state = _CurrentMonthCardState();
  @override
  // ignore: no_logic_in_create_state
  _CurrentMonthCardState createState() => state;
}

class _CurrentMonthCardState extends State<CurrentMonthCard> {
  Timer? timer;
  late SecondsExtract todayFlowTime;
  late SecondsExtract workingTime;
  late SecondsExtract flowWorkingTime;
  late bool isOverTime;
  @override
  void initState() {
    super.initState();
    isOverTime = widget.model.month.flowWorkingSeconds >= 0;
    todayFlowTime = SecondsExtract(widget.model.workingSecondsTody);
    if (widget.model.lastEntryTody?.isInput ?? false) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        int over = DateTime.now()
            .difference(DateTime.parse(widget.model.lastEntryTody!.date))
            .inSeconds;

        todayFlowTime = SecondsExtract(widget.model.workingSecondsTody + over);
        setState(() {});
      });
    } else {}
    workingTime = SecondsExtract(widget.model.month.workingSeconds);
    flowWorkingTime = SecondsExtract(widget.model.month.flowWorkingSeconds);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!
                      .trans("elapsed_time_today")),
                  Text(
                    todayFlowTime.toString2(),
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context)!.trans("required_working_hours")} ()",
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "${widget.model.month.requiredWorkingHours}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context)!.trans(isOverTime ? "overtime_working_hours_until_yesterday" : "uncompleted_working_hours_until_yesterday")} ()",
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  flowWorkingTime.toString2(),
                  style: TextStyle(
                    color: isOverTime ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context)!.trans("completed_working_hours_until_today")} ()",
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  workingTime.toString1(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
