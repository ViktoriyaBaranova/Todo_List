import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_to_do_app/controllers/task_controller.dart';
import 'package:my_to_do_app/models/task.dart';
import 'package:my_to_do_app/services/notif_services.dart';
import 'package:my_to_do_app/ui/add_task_bar.dart';
import 'package:my_to_do_app/ui/edit_task_bar.dart';
import 'package:my_to_do_app/ui/theme.dart';
import 'package:my_to_do_app/ui/widgets/button.dart';
import 'package:my_to_do_app/ui/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget{
  const HomePage ({Key? key}): super(key: key);

  @override
  _HomePageState createState() =>_HomePageState();
}
class _HomePageState extends State<HomePage>{
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;

  //метод инициализации
  // как только домашняя страница загрузится, плагин инициализируется
  @override
  void initState(){
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Todo List"), titleTextStyle: App_TitleStyle, backgroundColor: Colors.pink,),
      body: Column(
        children: [
          _addTaskBar(),//вторая строка с заголовком
          SizedBox(height: 10,),
          _showTasks(),
        ],
      ),
    );
  }


  _showTasks(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index]; //для добавления приложения в определенную дату**
                DateTime date = DateFormat.jm().parse(task.startTime.toString()); //*уведомления
                var myTime = DateFormat("HH:mm").format(date); //*
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]), //hours
                    int.parse(myTime.toString().split(":")[1]), //minutes
                    task
                ); //*

                return Row(
                          children: [
                            GestureDetector( //детектор жестов
                                onTap: () { // событие "касание"
                                  _showBottomSheet(context, task); //**
                                },
                                child: TaskTile(task) //**
                            )
                          ],
                  ); //показать задачу
              }

            );
      }),
    );
  }


  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4, left: 55),
        height: 80,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            //Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,// выравнивание по главной оси
              children:[
                _bottomSheetButton(label: Icon(Icons.event_available_rounded, size: 45,),
              onTap: (){
                _taskController.markTaskCompleted(task.id!);
                print("*******Compiled***");
                Get.back();
              },
              clr: Colors.purpleAccent,
              context: context, ),

            _bottomSheetButton(label: Icon(Icons.edit, size: 45,),
              onTap: () async{
                print("*******Edit***");
                await Get.to(()=>EditTaskPage());
                Get.back();
              },
              clr: Colors.redAccent,
              context: context, ),
            _bottomSheetButton(label: Icon(Icons.delete, size: 45,),
              onTap: (){
                _taskController.delete(task); //удалить задание
                Get.back();},
              clr: Colors.pinkAccent,
              context: context, ),
            SizedBox(),
            ],
            ),
          ],
        ),
     ),
    );
  }

  _bottomSheetButton({required Icon label,required Function()? onTap, required Color clr,bool isClose=false, required BuildContext context}){
    return GestureDetector(
      onTap:onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 53,
        width: 53,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Colors.grey[600]!:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child:  Center(child: label),
      ),
    );
  }


  //вторая строка с заголовком
  _addTaskBar(){
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),//отступы
        child: Row(//вторая строка со своими дочерними объектами
          mainAxisAlignment: MainAxisAlignment.end,// выравнивание по главной оси
          children: [
            MyButton(label: "Новая задача", onTap: () async { // кнопка "Add to do", вызываем страницу, на которую хотим перейти
              await Get.to(()=>AddTaskPage());
              _taskController.getTasks();
            }
            ),
          ],
        )
    );
  }

}