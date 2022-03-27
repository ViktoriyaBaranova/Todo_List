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
  int? color;
  String? repeat;

  Task({
    //инициализация данных
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.color,
    this.repeat,
  });
  Task.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    color = json['color'];
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
    data['color'] = this.color;
    data['repeat'] = this.repeat;
    return data;
  }
}