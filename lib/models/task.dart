//для записи данных в БД
//в каком виде будут сохранены данные
class Task{
  //поля модели
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? repeat;

  Task({
    //инициализация данных
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.repeat,
  });
  Task.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson(){
    //преобразование данных в формат json
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['repeat'] = this.repeat;
    return data;
  }
}