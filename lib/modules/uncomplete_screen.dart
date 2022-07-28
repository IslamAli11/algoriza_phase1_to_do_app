import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/component/task_item.dart';

class UncompletedScreen extends StatelessWidget {
  const UncompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var task =AppCubit.get(context).unCompleted;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
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
