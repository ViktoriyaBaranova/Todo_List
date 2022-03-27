import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_to_do_app/ui/theme.dart';


//компонент Input Field
class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top:16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( //заголовок Input Field
              title,
              style: titleStyle,
            ),
            Container(//поле Input Field
                height: 52,
                margin: EdgeInsets.only(top:8.0),
                padding: EdgeInsets.only(left:14.0),
                decoration: BoxDecoration(
                    border: Border.all( // серая рамка для поля
                        color: Colors.grey,
                        width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Expanded( //подсказака в поле Input Field
                        child: TextFormField(
                          readOnly: widget==null?false:true,//выбирать дату, а не печатать вручную
                          autofocus: false,
                          cursorColor: Colors.grey[700],
                          controller: controller,
                          style: subTitleStyle,
                          decoration: InputDecoration(
                              hintText: hint, //текст подсказки
                              hintStyle: subTitleStyle,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.theme.backgroundColor,
                                      width: 0
                                  )
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.theme.backgroundColor,
                                      width: 0
                                  )
                              )
                          ),
                        )
                    ),
                    widget==null?Container():Container(child: widget)
                  ],
                )
            )
          ],
        )
    );
  }
}
