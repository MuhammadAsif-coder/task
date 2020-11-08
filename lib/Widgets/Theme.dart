import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle textstyle() {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
}

Column columntext(String number, String text) => Column(
      children: [
        Text(number, style: textstyle()),
        SizedBox(height: 10.0),
        Text(
          text,
          style: TextStyle(
              color: Colors.black45, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
