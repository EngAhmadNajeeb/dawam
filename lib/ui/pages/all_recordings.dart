import 'package:dawam/blocs/months_bloc.dart';
import 'package:dawam/models/month.dart';
import 'package:dawam/ui/cards/month_logs_card.dart';
import 'package:dawam/ui/widgets/general_widget.dart';
import 'package:dawam/utilities/app_local.dart';
import 'package:flutter/material.dart';

class AllRecordings extends StatefulWidget {
  const AllRecordings({Key? key}) : super(key: key);

  @override
  State<AllRecordings> createState() => _AllRecordingsState();
}

class _AllRecordingsState extends State<AllRecordings> {
  MonthsBloc bloc = MonthsBloc();

  @override
  void initState() {
    super.initState();
    bloc.getMonths(context);
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
        title: Text(AppLocalizations.of(context)!.trans("all_recordings")),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<List<Month>>(
        stream: bloc.monthStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.length) {
                    return GeneralWidget.progressIndicator(
                        bloc.isLoadingStream);
                  } else {
                    return MonthLogsCard(month: snapshot.data![index]);
                  }
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 80,
                      width: 80,
                      child: Image(
                          image: AssetImage("assets/images/oops_data.png")),
                    ),
                    const SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!
                        .trans('There_are_no_records')),
                    ElevatedButton(
                      child:
                          Text(AppLocalizations.of(context)!.trans('refresh')),
                      onPressed: () {
                        // _refreshAll();
                      },
                    )
                  ],
                ),
              );
            }
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
