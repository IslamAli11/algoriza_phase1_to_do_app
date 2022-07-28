import 'package:algoriza_phase1_to_do_app/layout/cubit/cubit.dart';
import 'package:algoriza_phase1_to_do_app/layout/cubit/states.dart';
import 'package:algoriza_phase1_to_do_app/shared/component/no_tasks_screen.dart';
import 'package:algoriza_phase1_to_do_app/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/component/task_item.dart';

class BoardingScreen extends StatefulWidget {
 BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late LocalNotification localNotification;

  @override
  void initState() {
    super.initState();

    localNotification = LocalNotification();
    localNotification.intialize();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var task =AppCubit.get(context).tasks;



        if (task.isEmpty) {
          return Column(
            children: const [
              NoTasksScreen(),
              SizedBox(height: 10,),
            ],
          ) ;
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (context, index) {


              localNotification.showScheduledNotification(
                  id:task[index]['id'],
                  title:task[index]['title'],
                  body: task[index]['startTime'],
                  minutes:task[index]['remind']
              );

                return  TaskItem(task:task[index] ,);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemCount:task.length),
        );
      },

    );
  }
}
