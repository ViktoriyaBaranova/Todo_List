//для создания уведомлений
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_to_do_app/models/task.dart';
import 'package:my_to_do_app/ui/notified_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); //инициализация экземпляра плагина локального уведомления

  initializeNotification() async {
    //tz.initializeTimeZones();
    _configureLocalTimezone(); //*
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    //для Android
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("icon192"); //имя значка

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings, //параметр для инициализации
        onSelectNotification: selectNotification); //отображение содержимого один раз, когда кто-то ажимает на уведомление

  }

  scheduledNotification(int hour, int minutes, Task task) async { //запланированные уведомления, можно увидеть уведомление через 5 сек после инициализации
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(), //*
        task.title, //*
        task.note, //*
        _converTime(hour, minutes), //*
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), //* //через сколько секунд отправить уведомление
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name')), //, 'your channel description'
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|"+"${task.note}|" //*
    );

  }

  tz.TZDateTime _converTime(int hour, int minutes){ //*
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduledDate.isBefore(now)){

      scheduledDate = scheduledDate.add(const Duration(days:1));
    }
    return scheduledDate;
  }

  Future<void> _configureLocalTimezone() async{ //*
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high); //'your channel description',
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show( //что будет показано в уведомлении
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title, //* //звук уведомления
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future selectNotification(String? payload) async {//как только нажмем на уведомление, это перенесет нас на новую страницу
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(()=>NotifiedPage(label: payload)); //* //перевод на новую страницу

  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to flutter"));
  }
}