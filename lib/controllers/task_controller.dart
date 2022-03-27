import 'package:my_to_do_app/db/db_helper.dart';
import 'package:my_to_do_app/models/task.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:path/path.dart';


class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

//--------------
  /*Future<int> updateTask({Task? task}) async{
    return await DBHelper.update_my_task(task!);
  }*/
  void updateTask(Task task)async{
    await DBHelper.update_my_task(task);
    getTasks();
  }

}