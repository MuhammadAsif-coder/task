import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskapp/Screens/explore.dart';
import 'package:http/http.dart' as http;
import 'package:taskapp/Screens/gridview.dart';
import 'package:taskapp/Widgets/Theme.dart';
import 'package:taskapp/Widgets/cicleavatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void initState() {
    getdata();
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
            'Profile',
            style: textstyle(),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Explore()));
                  },
                  child: Icon(Icons.more_horiz)),
            )
          ],
        ),
        body: FutureBuilder(
          future: getdata(),
          builder: (context, snapShot) {
            Map data = snapShot.data;
            if (snapShot.hasError) {
              print(snapShot.error);
              return Text(
                'Failed to get Response from the server',
                style: TextStyle(color: Colors.red, fontSize: 22.0),
              );
            } else if (snapShot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      circleAvatar(35, 33, data['data']['avatar']),
                      SizedBox(height: 20.0),
                      Text(
                        data['data']['first_name'] +
                            '\t' +
                            data['data']['last_name'],
                        style: textstyle(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          data['ad']['text'],
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(wordSpacing: 2, color: Colors.black45),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Divider(
                        thickness: 0.2,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          columntext('238', 'Posts'),
                          columntext('238', 'Followings'),
                          columntext('238K', 'Followers'),
                        ],
                      ),
                      Divider(
                        thickness: 0.2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                height: 40,
                                width: 120,
                                color: Colors.lightBlue[600],
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.lightBlue[600],
                                  ),
                                  onPressed: () {
                                    // Respond to button press
                                  },
                                  child: Text(
                                    "Follow",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            Container(
                                height: 40,
                                width: 120,
                                child: OutlineButton(
                                  borderSide:
                                      BorderSide(color: Colors.lightBlue[600]),
                                  onPressed: () {
                                    // Respond to button press
                                  },
                                  child: Text("Message"),
                                ))
                          ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Photos',
                            style: textstyle(),
                          ),
                          Spacer(),
                          Icon(
                            Icons.list,
                            size: 30,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.grid_view,
                            size: 25,
                            color: Colors.black45,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(child: MyGridview(data: data)),
                    ],
                  ),
                ),
              );
            } else if (!snapShot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<Map> getdata() async {
    http.Response response = await http.get('https://reqres.in/api/users/2');

    return json.decode(response.body);
  }
}
