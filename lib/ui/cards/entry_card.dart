import 'package:dawam/models/entry.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  const EntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Visibility(
                  visible: entry.isInput,
                  child: Row(
                    children: [
                      const Icon(Icons.login, color: Colors.green),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.trans('input'),
                      ),
                    ],
                  ),
                  replacement: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.trans('output'),
                      ),
                    ],
                  ),
                ),
              ),
              Text(entry.getTime()),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
