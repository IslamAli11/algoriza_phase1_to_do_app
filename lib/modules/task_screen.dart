import 'package:algoriza_phase1_to_do_app/layout/cubit/cubit.dart';
import 'package:algoriza_phase1_to_do_app/layout/cubit/states.dart';
import 'package:algoriza_phase1_to_do_app/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../shared/component/default_text.dart';
import '../shared/component/default_text_button.dart';
import '../shared/component/default_text_form_field.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key}) : super(key: key);


  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  var titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
       return Scaffold(
          appBar: AppBar(
            elevation: 1,
            titleSpacing: 10,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_outlined)),
            title: const Text('Add task'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const DefaultText(
                          text: 'Title',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultTextFormFiled(
                          controller: titleController,
                          validate: 'Title mus\'t be empty',
                          hintText: 'Title task',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DefaultText(
                          text: 'Date',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultTextFormFiled(
                          hintText: DateFormat.yMd().format(cubit.selectedDate),
                          suffixIcon: IconButton(
                            onPressed: (){
                              showDate();

                            },
                            icon: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: DefaultText(
                                text: 'Start time',
                              ),
                            ),
                            Expanded(
                              child: DefaultText(
                                text: 'End time',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DefaultTextFormFiled(
                                suffixIcon:IconButton(
                                  onPressed:(){
                                    showTime(isStartTime: true);
                                  },
                                  icon:Icon(Icons.watch_later_outlined),

                                ),
                                hintText: cubit.startTime,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: DefaultTextFormFiled(
                                suffixIcon: IconButton(
                                  onPressed:(){
                                    showTime(isStartTime:false);
                                  },
                                  icon:Icon(Icons.watch_later_outlined),

                                ),
                                hintText: cubit.endTime,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DefaultText(
                          text: 'Remind',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultTextFormFiled(
                          hintText: '${cubit.selectedRemind} minutes early',
                          suffixIcon: PopupMenuButton(
                            onSelected:(int value){
                             cubit.remindChange(remind: value);

                            },
                            icon: Icon(Icons.keyboard_arrow_down),
                            itemBuilder: (context) =>
                                cubit.remindList.map((e) =>
                                    PopupMenuItem(
                                      value: e,
                                      child: Text('$e'),),).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const DefaultText(
                          text: 'Repeat',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultTextFormFiled(
                          suffixIcon: PopupMenuButton(
                            onSelected:(String value){
                            cubit.repeatChange(repeat: value);

                            },
                            icon: Icon(Icons.keyboard_arrow_down),
                            itemBuilder: (context) =>
                                cubit.repeatList.map((e) =>
                                    PopupMenuItem(
                                      value: e,
                                      child: Text(e),),).toList(),
                          ),
                          hintText: cubit.selectedRepeat,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const DefaultText(text: 'Task color'),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          children: List<Widget>.generate(
                            3,
                                (index) => GestureDetector(
                              onTap: () {
                               cubit.colorChange(color: index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  child: cubit.selectedColor == index
                                      ? const Icon(Icons.done, size: 16, color: Colors.white)
                                      : null,
                                  backgroundColor: index == 0
                                      ? Colors.red
                                      : index == 1
                                      ? Colors.yellow
                                      : Colors.teal,
                                  radius: 14,
                                ),
                              ),
                            ),
                          ),

                        ),

                      ],
                    ),
                  ),
                  DefaultTextButton(
                      text: 'Create a Task',
                      color: Colors.green,
                      fontSize: 18,
                      textColor: Colors.white,
                      onPress: () {
                        if(formKey.currentState!.validate()){
                          cubit.insertTaskData(
                              title: titleController.text,
                              date:DateFormat.yMd().format(cubit.selectedDate),
                              startTime: cubit.startTime,
                              endTime: cubit.endTime,
                              color: cubit.selectedColor,
                              remind: cubit.selectedRemind,
                              repeat:cubit.selectedRepeat
                          );
                          Navigator.pop(context);

                        }


                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  showDate()async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate:DateTime.now(),
        firstDate:DateTime.now(),
        lastDate: DateTime(2070)
    );
    if (pickedDate != null) {
      setState(() => AppCubit.get(context).selectedDate = pickedDate);
    } else {
      debugPrint('date error');
    }


}


  showTime({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 20))),
    );
    String formattedTime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() => AppCubit.get(context).startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => AppCubit.get(context).endTime = formattedTime);
    } else {
      debugPrint('time Error');
    }
  }





 }
