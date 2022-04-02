import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/ui/cards/entry_card.dart';
import 'package:flutter/material.dart';

import 'package:dawam/models/day.dart';

class DayLogsCard extends StatelessWidget {
  final Day day;

  const DayLogsCard({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Column(
          children: [
            Card(
              color: Colors.yellow[700],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day.getDate(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          SecondsExtract(day.workingSeconds).toStringWithType(context),
                          style: const TextStyle(
                            fontSize: 16,
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: day.entries.length,
              itemBuilder: (context, entryIndex) {
                return EntryCard(entry: day.entries[entryIndex]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
