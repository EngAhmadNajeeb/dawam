import 'package:dawam/blocs/month_bloc.dart';
import 'package:dawam/models/month.dart';
import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/ui/cards/day_logs_card.dart';
import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class MonthRecordings extends StatefulWidget {
  final Month month;
  const MonthRecordings({Key? key, required this.month}) : super(key: key);
  @override
  State<MonthRecordings> createState() => _MonthRecordingsState();
}

class _MonthRecordingsState extends State<MonthRecordings> {
  MonthBloc bloc = MonthBloc();
  @override
  void initState() {
    super.initState();
    bloc.getMonth(context, widget.month.id);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SecondsExtract(widget.month.workingSeconds)
              .toStringWithType2(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<Month>(
        stream: bloc.monthStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.days.length,
              itemBuilder: (context, index) {
                return DayLogsCard(day: snapshot.data!.days[index]);
              },
            );
          }
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              GeneralWidget.listProgressIndicator()
            ],
          );
        },
      ),
    );
  }
}
