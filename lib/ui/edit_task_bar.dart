import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_do_app/controllers/task_controller.dart';
import 'package:my_to_do_app/models/task.dart';
import 'package:my_to_do_app/ui/home_page.dart';
import 'package:my_to_do_app/ui/theme.dart';
import 'package:my_to_do_app/ui/widgets/button.dart';
import 'package:my_to_do_app/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class EditTaskPage extends StatefulWidget {
  String title = "Название задачи";
  String note = "Описание задачи";
  String date = "3/6/2022";
  String repeat = "Нет";
  String startTime = "00:00 AM";
  int id = 0;
  EditTaskPage({Key? key,
    required this.title,
    required this.note,
    required this.date,
    required this.repeat,
    required this.startTime,
    required this.id
  }) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState(this.title, this.note, this.date, this.repeat, this.startTime, this.id);
}

class _EditTaskPageState extends State<EditTaskPage> {
  String title = "Название задачи";
  String note = "Описание задачи";
  String date = "3/6/2022";
  String repeat = "Нет";
  String startTime = "00:00 AM";
  int id = 0;
  _EditTaskPageState(this.title, this.note, this.date, this.repeat, this.startTime, this.id);

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  List<String> repeatList = ["Нет", "Да"];
  bool isShowDate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView( //виджет для прокрутки
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text("Add Task", style: headingStyle,),
                  MyInputField(title: "Заголовок", hint: title, controller: _titleController,),
                  MyInputField(title: "Описание", hint: note, controller: _noteController,),
                  MyInputField(
                    title: "Дата",
                    hint: date,
                    widget: IconButton(
                      icon: Icon(Icons.calendar_today, color: Colors.grey),
                      onPressed: (){
                        _showDate(); //при нажатии на иконку, появляется календарь
                      },
                    ),
                  ), //для поля Data
                  MyInputField(
                    title: ""
                        "Напомнить",
                    hint: repeat,
                    widget: DropdownButton( //выпадающее меню
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                      iconSize: 32,
                      elevation: 4, //высота значка
                      style: subTitleStyle,
                      underline: Container(height: 0,),
                      onChanged: (String? newValue){
                        setState(() {
                          repeat = newValue!;
                        });
                      },
                      items: repeatList.map<DropdownMenuItem<String>>((String? value) { //элементы выпадающего меню
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value!, style: TextStyle(color: Colors.grey))
                        );
                      }).toList(),
                    ),
                  ), //для поля Repeat
                  //выбор цвета и кнопка Creat
                  Row(
                    children: [
                      Expanded(
                        child: MyInputField(
                          title: "Время напоминания",
                          hint: startTime,
                          widget: IconButton(
                              onPressed: (){
                                _showTime();
                              },
                              icon: Icon(Icons.access_alarm, color: Colors.grey)
                          ),
                        ),
                      ),
                    ],
                  ),  //для поля Time
                  SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //кнопка Create
                      MyButton(label: "    Обновить",
                          onTap: () => _validateDate()),
                    ],
                  )
                  //кнопка Creat
                ],
              )
          )

      ),

    );
  }

  //проверить, пусты ли поля Input Field
  _validateDate(){
    if(_titleController.text.isEmpty){
      _titleController.text = title;
    }
    if (_noteController.text.isEmpty){
      _noteController.text = note;
    }
    //update
      _taskController.updateTask(
          _titleController.text,
          _noteController.text,
          date,
          repeat,
          startTime,
          id);
      Get.back();
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Редактировать задачу"),
      titleTextStyle: subHeadingStyle,
      backgroundColor: Colors.red[400],
      leading: GestureDetector(
        onTap: () { //событие для кнопки "назад"
          Get.back();
        },
        child: Icon(Icons.arrow_back, size: 20, color: Colors.white),
      ),
    );
  }

  //функция, которая будет показывать календарь
  _showDate() async{
    //isShowDate = true;
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //начальная дата
        firstDate: DateTime(2020),
        lastDate: DateTime(2028)
    );
    if (_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
        date = DateFormat.yMd().format(_selectedDate);
      });
    }
    else{
      print("it's null");
    }
  }

  //функция, которая будет показывать часы для задания времени
  _showTime() async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime!=null){
      setState(() {
        startTime = _formatedTime;
      });
    }else{
      print("it's null");

    }
  }

  //время, указанное в подсказке
  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
