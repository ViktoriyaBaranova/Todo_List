import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_to_do_app/ui/theme.dart';


//для кнопки "Add to do"
class MyButton extends StatelessWidget{
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector ( //детектор жестов
      onTap: onTap,
      child: Container( //форма кнопки
        padding: EdgeInsets.only(top:10, left:10.0), //отступы для текста
        width: 125, // ширина кнопки
        height: 40, // высота кнопки
        decoration: BoxDecoration ( //закругленные края у кнопки
            borderRadius: BorderRadius.circular(12),
            //color: primaryClr
          color: Colors.pink,
        ),
        //текст кнопки
        child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )
        ),
      ),

    );
  }
}