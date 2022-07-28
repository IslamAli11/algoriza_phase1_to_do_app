import 'package:algoriza_phase1_to_do_app/models/task_model.dart';
import 'package:algoriza_phase1_to_do_app/shared/component/no_tasks_screen.dart';
import 'package:algoriza_phase1_to_do_app/shared/component/show_task.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);
  DateTime selectedTime = DateTime.now();
  DatePickerController datePickerController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Schedule'),
            titleSpacing: 6,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DatePicker(
                  selectedTime,
                  initialSelectedDate: selectedTime,
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    cubit.dateChange(date: date);

                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      DateFormat('EEEE').format(selectedTime),
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat.yMMMMd('en-AU').format(selectedTime),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              if (cubit.tasks.isEmpty)
              const NoTasksScreen(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (cubit.tasks[index]['repeat'] == 'Daily' ||
                        cubit.tasks[index]['date'] ==
                            DateFormat.yMd().format(cubit.selectedDate) ||
                        (cubit.tasks[index]['repeat'] == 'Weekly' &&
                            cubit.selectedDate
                                        .difference(DateFormat.yMd()
                                            .parse(cubit.tasks[index]['date']))
                                        .inDays %
                                    7 ==
                                0) ||
                        (cubit.tasks[index]['repeat'] == 'Monthly' &&
                            DateFormat.yMd()
                                    .parse(cubit.tasks[index]['date'])
                                    .day ==
                                cubit.selectedDate.day)) {

                      return ShowTask(
                        task: cubit.tasks[index],
                      );
                    }
                    return Container();
                  },
                  itemCount: AppCubit.get(context).tasks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
