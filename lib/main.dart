import 'package:flutter/material.dart';
import 'package:my_to_do_app/db/db_helper.dart';
import 'package:my_to_do_app/ui/home_page.dart';
import 'package:my_to_do_app/ui/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false, //убрать надпись 'Debag'
        theme: Themes.light,
        home: HomePage()
    );
  }
}
