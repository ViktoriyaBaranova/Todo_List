import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_to_do_app/models/task.dart';


class TaskTile extends StatelessWidget {
  final Task? task;
  TaskTile(this.task);
  bool isChecked=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.pink[200],

        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      task!.repeat == "Да"? Icons.access_time_rounded:Icons.timer_off,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      task!.repeat == "Да"? "${task!.startTime}   ":"----  ",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    Text(
                      " ${task!.date}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  task?.note??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: task!.isCompleted == 1 ?
            Icon(Icons.event_available_rounded, color: Colors.greenAccent[100],):
            Icon(Icons.turned_in_not, color: Colors.pinkAccent,),
          ),
        ]),
      ),
    );
  }

}
