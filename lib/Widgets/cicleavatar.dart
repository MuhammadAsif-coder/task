import 'package:flutter/material.dart';

CircleAvatar circleAvatar(double radius1, double radius2, String img) =>
    CircleAvatar(
      radius: radius1,
      backgroundColor: Colors.lightBlue[600],
      child: CircleAvatar(
        radius: radius2,
        backgroundImage: NetworkImage(
          img,
        ),
      ),
    );
