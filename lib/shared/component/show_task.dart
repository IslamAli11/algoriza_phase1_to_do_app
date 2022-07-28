import 'package:algoriza_phase1_to_do_app/layout/cubit/states.dart';
import 'package:algoriza_phase1_to_do_app/models/task_model.dart';
import 'package:algoriza_phase1_to_do_app/shared/component/default_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import 'component.dart';

class ShowTask extends StatelessWidget {
  ShowTask({Key? key, required this.task}) : super(key: key);

  Map task;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (cubit, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: getColor(task['color']),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${task['startTime']}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${task['title']}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        defaultCheckBox(
                            radius: 25,
                            bigWidthContainer: 24,
                            bigHeightContainer: 24,
                            smallHeightContainer: 21,
                            smallWidthContainer: 21,
                            bigContainerColor: task['status'] == 'new' ||
                                    task['status'] == 'unCompeted'
                                ? getColor(task['color'])
                                : Colors.white,
                            smallContainerColor: task['status'] == 'new' ||
                                    task['status'] == 'completed' ||
                                    task['status'] == 'unCompleted' ||
                                    task['status'] == 'favorite'
                                ? getColor(task['color'])
                                : Colors.white,
                            iconSize: task['status'] == 'unCompleted' ||
                                    task['status'] == 'favorite'
                                ? 0
                                : 13),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
