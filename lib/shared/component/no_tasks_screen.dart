
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoTasksScreen extends StatelessWidget {
   const NoTasksScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     return   Center(
       child: Container(
         child: Column(
           children:  [
             SizedBox(
               height: height* 0.27,
             ),
             Icon(
               Icons.note_add_rounded,
               size: 100,
             ),
             SizedBox(
               height: 10,
             ),
             Text(
               'No Tasks',
               style: TextStyle(
                   fontSize: 25, fontWeight: FontWeight.bold),
             ),
           ],
         ),
       ),
     );
   }
 }
