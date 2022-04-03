import 'package:dawam/models/seconds_extract.dart';
import 'package:dawam/utilities/data_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dawam/utilities/app_local.dart';

class SalaryCalculator extends StatefulWidget {
  const SalaryCalculator({Key? key}) : super(key: key);

  @override
  State<SalaryCalculator> createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController totalHoursController = TextEditingController();
  TextEditingController currentHoursController = TextEditingController();
  TextEditingController currentMinutesController = TextEditingController();
  double hourlySalary = 0;
  double dailySalary = 0;
  double receivedSalary = 0;
  @override
  void initState() {
    totalHoursController.text =
        "${dataStore.current?.requiredWorkingHours ?? 0}";
    currentHoursController.text =
        "${SecondsExtract(dataStore.current?.workingSeconds ?? 0).hours}";
    currentMinutesController.text =
        "${SecondsExtract(dataStore.current?.workingSeconds ?? 0).minutes}";

    super.initState();
  }

  @override
  void dispose() {
    salaryController.dispose();
    totalHoursController.dispose();
    currentHoursController.dispose();
    currentMinutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.trans("salary_calculator")),
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Card(
                      child: TextField(
                        controller: salaryController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.trans("salary"),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${AppLocalizations.of(context)!.trans("required_working_hours")} (${dataStore.current?.getMonthName()})",
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: totalHoursController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${AppLocalizations.of(context)!.trans("work_hours_completed")} (${dataStore.current?.getMonthName()})",
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: currentHoursController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .trans("hour"),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: currentMinutesController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .trans("minute"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(AppLocalizations.of(context)!
                              .trans("salary_calculation")),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (salaryController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .trans("enter_salary"),
                              );
                            } else if (totalHoursController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .trans("enter_work_hours_completed"),
                              );
                            } else if (currentHoursController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .trans("enter_actual_working_hours"),
                              );
                            } else if (currentMinutesController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!
                                    .trans("enter_actual_working_Minutes"),
                              );
                            } else {
                              setState(() {
                                hourlySalary =
                                    double.parse(salaryController.text) /
                                        double.parse(totalHoursController.text);
                                dailySalary = (double.parse(
                                        salaryController.text) /
                                    double.parse(totalHoursController.text) *
                                    8);
                                receivedSalary = hourlySalary *
                                    (double.parse(currentHoursController.text) +
                                        double.parse(
                                                currentMinutesController.text) /
                                            60);
                              });
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.trans("hourly_salary")),
                      Text(hourlySalary.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.trans("daily_salary")),
                      Text(dailySalary.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trans("received_salary"),
                      ),
                      Text(receivedSalary.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
