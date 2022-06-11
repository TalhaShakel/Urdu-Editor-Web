import 'package:flutter/material.dart';

class button extends StatelessWidget {
  var width;

  var height;

  var onPressed;

  String text;

  button({
    required this.height,
    required this.onPressed,
    required this.text,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
          style: ElevatedButton.styleFrom(
              primary: Colors.indigoAccent, //background color of button
              side: BorderSide(
                  width: 2, color: Colors.white), //border width and color
              elevation: 3, //elevation of button
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.only(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  top: 15) //content padding inside button
              )),
    );
  }
}
