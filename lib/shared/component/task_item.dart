import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';
import 'component.dart';
import 'default_checkbox.dart';

class TaskItem extends StatelessWidget {
  TaskItem({Key? key, required this.task}) : super(key: key);

  Map task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task['id'].toString()),
      child: Row(
        children: [
          defaultCheckBox(
              iconColor: Colors.red,
              bigContainerColor: getColor(task['color']),
              iconSize: task['status'] == 'unCompleted' ||
                  task['status'] == 'favorite' ||
                  task['status'] == 'favorite'
                  ? 0
                  : 18,
              radius: 8),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${task['title']}',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          const Spacer(),
          PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    AppCubit.get(context).updateTaskStatus(
                        status: 'completed', id: task['id']);
                  },
                  child: const Text("Completed"),
                  value: 1,
                ),
                PopupMenuItem(
                  onTap: () {
                    AppCubit.get(context).updateTaskStatus(
                        status: 'unCompleted', id: task['id']);
                  },
                  child: const Text("Uncompleted"),
                  value: 2,
                ),
                PopupMenuItem(
                  onTap: () {
                    AppCubit.get(context).updateTaskStatus(
                        status: 'favorite', id: task['id']);
                  },
                  child: const Text("Favorite"),
                  value: 3,
                ),
                PopupMenuItem(
                  onTap: () {
                    AppCubit.get(context).deleteTask(id: task['id']);
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                  value: 4,
                ),
              ]),
        ],
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteTask(id: task['id']);
      },
    );
  }
}