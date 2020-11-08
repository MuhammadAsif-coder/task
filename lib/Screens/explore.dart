import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskapp/Model/chat.dart';
import 'package:taskapp/Widgets/Theme.dart';
import 'package:taskapp/Widgets/cicleavatar.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool isloading = false;
  List<Chat> chatlist = List();
  void initState() {
    getchatdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: Colors.black),
          leading: Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          title: Text(
            'Explore',
            style: textstyle(),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Container(
          child: isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: chatlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                circleAvatar(20, 20,
                                    "https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Krisitian Jones',
                                      style: textstyle(),
                                    ),
                                    Text(
                                      '20 Minutes ago',
                                    )
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.more_horiz,color: Colors.black45)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.chat_bubble_outline,color: Colors.black45),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('254',style:TextStyle(color: Colors.black45)),
                                  ],
                                ),
                                
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  child: Text(
                                    chatlist[index].name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(wordSpacing: 1.5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.red[400],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('3456',style:TextStyle(color: Colors.black45)),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  height: 200,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ));
                  }),
        ));
  }

  Future<Map> getchatdata() async {
    setState(() {
      isloading = true;
    });
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    print(response.body);
    print(response.body[0]);
    if (response.statusCode == 200) {
      chatlist = (json.decode(response.body) as List)
          .map((data) => new Chat.fromJson(data))
          .toList();
      setState(() {
        isloading = false;
      });
    }
  }
}
