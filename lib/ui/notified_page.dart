//страница уведомления
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_app/ui/theme.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black,),
        ),
        title: Text("Todo"),

      ),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(this.label.toString().split("|")[0], style: headingStyle),
            SizedBox(height: 5,),
            Container(color: Colors.pink, width: 400, height: 3,),
            SizedBox(height: 20,),
            Center(child: Text(this.label.toString().split("|")[1], style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black))),
          ],
        )
        ),
    );
  }
}
