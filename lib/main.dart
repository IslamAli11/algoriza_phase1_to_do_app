import 'package:algoriza_phase1_to_do_app/layout/home_screen.dart';
import 'package:algoriza_phase1_to_do_app/shared/bloc_observer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:algoriza_phase1_to_do_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();


  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());

    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>AppCubit()..initDatabase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: primaryColor,
            appBarTheme: const AppBarTheme(
              titleSpacing: 25,
              toolbarTextStyle: TextStyle(color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
              actionsIconTheme: IconThemeData(
                  color: Colors.black
              ),
              color: primaryColor,
            )
        ),
        home: HomeScreen(),
      ),
    );
  }


}

