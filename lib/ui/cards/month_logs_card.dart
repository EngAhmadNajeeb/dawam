import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/ui/pages/month_recordings.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';

import 'package:dawam/models/month.dart';

class MonthLogsCard extends StatelessWidget {
  final Month month;
  const MonthLogsCard({
    Key? key,
    required this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        // color: Colors.amber,
        child: Column(
          children: [
            Container(
              color: Colors.grey[400],
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      month.getDate(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          SecondsExtract(month.workingSeconds)
                              .toStringWithType2(context),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.trans(
                      month.flowWorkingSeconds >= 0
                          ? "overtime_working_hours"
                          : "uncompleted_working_hours")),
                  Text(
                    SecondsExtract(month.flowWorkingSeconds)
                        .toStringWithType1(context),
                    style: TextStyle(
                      color: month.flowWorkingSeconds >= 0
                          ? Colors.blue
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!
                      .trans("required_working_hours")),
                  Text(
                    "${month.requiredWorkingHours}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(AppLocalizations.of(context)!.trans("details")),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MonthRecordings(
                        month: month,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
