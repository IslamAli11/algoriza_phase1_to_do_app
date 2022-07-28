import 'package:algoriza_phase1_to_do_app/layout/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);


  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int selectedRemind = 5;
  int selectedColor = 0;
  List<int> remindList = [5, 10, 20, 30];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];


  List<Map> tasks = [];
  List<Map>unCompleted=[];
  List<Map>completed=[];
  List<Map>favorite=[];
  late Database database;
  static const String tableTask = 'tasks';

  colorChange({required int color}){

    selectedColor = color;
    emit(ChangeColorState());
  }

  remindChange({required int remind}){
    selectedRemind = remind;
    emit(RemindChangeState());
  }

  repeatChange({required String repeat}){
   selectedRepeat = repeat;
    emit(RepeatChangeState());
  }
  dateChange({required date}){
    selectedDate = date;
    emit(DateChanged());

  }


  dynamic initDatabase() async {
    String databasesPath = await getDatabasesPath();
    var path = p.join(databasesPath, 'tasks.db');
    emit(DatabaseInitialized());
    debugPrint('database initialized');
    openingDatabase(path: path);
  }

  void openingDatabase({required String path}) {
    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $tableTask(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, startTime TEXT,endTime TEXT, remind INTEGER, repeat TEXT,color INTEGER,status TEXT)",
      );

      debugPrint('database created');
    }, onOpen: (Database db) {
      emit(DatabaseOpened());
      database = db;
      debugPrint('database opened');

      getTasks(database);
    });
  }



  void insertTaskData({
  required String title,
    required String date,
    required String startTime,
    required String endTime,
    required int color,
    required int remind,
    required String repeat,

}){
    if(tasks.isNotEmpty){
     database.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO tasks(title, date, startTime,endTime,remind,repeat,color, status) VALUES("$title", "$date", "$startTime","$endTime","$remind","$repeat","$color", "unCompleted")',
      ).then((value){
        emit(SuccessInsertedTaskState());
        getTasks(database);
        debugPrint(value.toString());

      }).catchError((error){
        debugPrint(error.toString());
        emit(ErrorInsertedTaskState());
      });

    });
    }else {
      database.transaction((txn) async {
      txn.rawInsert(
      'INSERT INTO tasks(title, date, startTime,endTime,remind,repeat,color, status) VALUES("$title", "$date", "$startTime","$endTime","$remind","$repeat","$color", "unCompleted")',
      ).then((value){
        emit(SuccessInsertedTaskState());
        getTasks(database);
        debugPrint(value.toString());

      }).catchError((error){
        debugPrint(error.toString());
        emit(ErrorInsertedTaskState());
      });

    });
    }

  }



  void getTasks(database) async {
       tasks = [];
      completed = [];
      favorite = [];
      unCompleted=[];
       emit(GetTasksLoadingState());

      database.rawQuery('SELECT * FROM tasks').then((value) {
        tasks=value;
        value.forEach((element)
        {
          if(element['status'] == 'new') {
            tasks.add(element);
            emit(TaskedAdded());
          } else if(element['status'] == 'completed') {
            completed.add(element);
            emit(TaskBecomeCompleted());
            if(element['status']=='favorite') {
              favorite.add(element);
              emit(TaskBecomeFavorite());
            }
          } else if(element['status']=='unCompleted') {
            unCompleted.add(element);
            emit(TaskBecomeUncompleted());
            if(element['status']=='favorite') {
              favorite.add(element);
              emit(TaskBecomeFavorite());
            }
          }else{
            favorite.add(element);
            emit(TaskBecomeFavorite());
          }
        });
      debugPrint(tasks.toString());
        emit(SuccessGetTaskState());
      });

  }
  void updateTaskStatus({
    required String status,
    required int id,
  }) async
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value)
    {
      getTasks(database);
       emit(TaskStatusUpdated());
    });
  }

  void deleteTask({required int id}) async {
    database
        .rawDelete('DELETE FROM $tableTask WHERE id = ?', [id]).then((value) {
      getTasks(database);
      emit(TaskDataDeleted());
    });
  }
}
