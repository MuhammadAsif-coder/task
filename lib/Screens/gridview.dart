import 'package:flutter/material.dart';

class MyGridview extends StatelessWidget {
  const MyGridview({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 9,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15, mainAxisSpacing: 12, crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data['data']['avatar']))),
          );
        });
  }
}
