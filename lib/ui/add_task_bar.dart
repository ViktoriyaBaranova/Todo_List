import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_do_app/controllers/task_controller.dart';
import 'package:my_to_do_app/models/task.dart';
import 'package:my_to_do_app/ui/theme.dart';
import 'package:my_to_do_app/ui/widgets/button.dart';
import 'package:my_to_do_app/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedRepeat = "Нет";
  List<String> repeatList = ["Нет", "Да"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView( //виджет для прокрутки
              child: Column(
                children: [
                  MyInputField(title: "Заголовок", hint: "Введите заголовок", controller: _titleController,),
                  MyInputField(title: "Описание", hint: "Введите описание", controller: _noteController,),
                  MyInputField(
                    title: "Дата",
                    hint: DateFormat.yMd().format(_selectedDate),
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
                    hint: "$_selectedRepeat",
                    widget: DropdownButton( //выпадающее меню
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,),
                      iconSize: 32,
                      elevation: 4, //высота значка
                      style: subTitleStyle,
                      underline: Container(height: 0,),
                      onChanged: (String? newValue){
                        setState(() {
                          _selectedRepeat = newValue!;
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
                          hint: _startTime,
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
                        MyButton(label: "    Добавить",
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
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      //add to database
      _addTaskToDb();
      Get.back();
    } else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Ошибка", "Заголовок и(или) описание не должны быть пустыми!",
          //стили
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          icon: Icon(Icons.warning_amber_outlined, color: Colors.red,),

      );
    }
  }

  _addTaskToDb() async{
    int value = await _taskController.addTask(
        task: Task(
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          repeat: _selectedRepeat,
          isCompleted: 0,
        )
    );
    print("My id is " + "$value");
  }


  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("Добавить задачу"),
      titleTextStyle: subHeadingStyle,
      //backgroundColor: context.theme.backgroundColor,
      backgroundColor: Colors.pink,
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
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //начальная дата
        firstDate: DateTime(2020),
        lastDate: DateTime(2028)
    );
    if (_pickerDate!=null){
      setState(() {
        _selectedDate=_pickerDate;
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
        _startTime = _formatedTime;
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
