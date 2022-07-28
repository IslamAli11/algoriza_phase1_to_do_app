import 'package:algoriza_phase1_to_do_app/layout/cubit/cubit.dart';
import 'package:algoriza_phase1_to_do_app/layout/cubit/states.dart';
import 'package:algoriza_phase1_to_do_app/modules/boarding_screen.dart';
import 'package:algoriza_phase1_to_do_app/modules/complete_screen.dart';
import 'package:algoriza_phase1_to_do_app/modules/favorites_screen.dart';
import 'package:algoriza_phase1_to_do_app/modules/schedule_screen.dart';
import 'package:algoriza_phase1_to_do_app/modules/task_screen.dart';
import 'package:algoriza_phase1_to_do_app/modules/uncomplete_screen.dart';
import 'package:algoriza_phase1_to_do_app/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/component/default_text_button.dart';

class HomeScreen extends StatefulWidget {
 HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocalNotification localNotification;
  @override
  void initState() {
   localNotification = LocalNotification();
   localNotification.intialize();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScheduleScreen()));
              },
              icon: const Icon(Icons.calendar_today)),
        ],
        elevation: 1,
        title: const Text('Board'),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: DefaultTabController(
                length: 4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const TabBar(
                          indicatorColor: Colors.black,
                          isScrollable: true,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 15),
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'All'),
                            Tab(text: 'Completed'),
                            Tab(text: 'Uncompleted'),
                            Tab(text: 'Favorite'),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.7,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey.shade300, width: 1))),
                        child:  TabBarView(children: [
                          BoardingScreen(),
                          const CompletedScreen(),
                          const UncompletedScreen(),
                          const FavoriteScreen(),
                        ]),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: DefaultTextButton(
                            text: 'Add a task',
                            color: Colors.green,
                            fontSize: 18,
                            textColor: Colors.white,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TasksScreen()));
                            }),
                      ),
                    ])),
          );
        },
      ),
    );
  }
}
