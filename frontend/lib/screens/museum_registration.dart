import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:frontend/components/custom_surfix_icon.dart';
import 'package:frontend/models/Museum.dart';
import 'package:frontend/screens/sign_in/components/sign_form.dart';
import 'package:frontend/screens/sign_in/sign_in_screen.dart';
import 'package:frontend/screens/write_review.dart';
import 'package:frontend/models/Desc.dart';
import 'package:frontend/constants.dart';

final dio = Dio();

class MuseumRegistration extends StatefulWidget {
  MuseumRegistration({Key? key, required this.oid}) : super(key: key);
  final String? oid;
  @override
  _Museum createState() => _Museum();
}

class _Museum extends State<MuseumRegistration> {
  final _formKey = GlobalKey<FormState>();
  String? museumName;
  String? inTime;
  String? outTime;
  String? info;
  var tags = [];
  String? fname;
  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  bool flag4 = false;
  bool flag5 = false;
  bool flag6 = false;
  void save() async {
    print(inTime);
    print(museumName);
    print(outTime);
    print(info);
    print(widget.oid);
    var params = {
      'ownerID': widget.oid,
      'museumName': museumName,
      'inTime': inTime,
      'outTime': outTime,
      'tags': tags,
      'aboutMuseum': info,
    };
    Response response = await dio.post(
      '$apiUrl/api/museumOwner/addMuseumDetails',
      data: jsonEncode(params),
    );
  }

  void initState() {
    print(widget.oid);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          children: [
            Container(
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Column(children: [
                  Text('Thanks for registering!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'We would love to know a little bit  \n more about your museum',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1ce0e2),
                          fontSize: 15,
                          fontWeight: FontWeight.w400))
                ])),
            SizedBox(height: 50),
            Form(
                key: _formKey,
                child: Container(
                    height: 500,
                    child: Column(children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        // obscureText: true,
                        onSaved: (newValue) => museumName = newValue,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value) {
                          setState(() {
                            museumName = value;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Museum Name",
                            filled: true,
                            fillColor: Color(0xff1a1a1a),
                            labelStyle: TextStyle(color: Color(0xfffa256a)),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: Icon(Icons.text_fields)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                onSaved: (newValue) => inTime = newValue,
                                onChanged: (value) {
                                  setState(() {
                                    inTime = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: "In Time (am)",
                                    filled: true,
                                    fillColor: Color(0xff1a1a1a),
                                    labelStyle:
                                        TextStyle(color: Color(0xfffa256a)),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    suffixIcon: Icon(Icons.watch)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              onSaved: (newValue) => museumName = newValue,
                              onChanged: (value) {
                                setState(() {
                                  outTime = value;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: "Out Time (pm)",
                                  filled: true,
                                  fillColor: Color(0xff1a1a1a),
                                  labelStyle:
                                      TextStyle(color: Color(0xfffa256a)),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  suffixIcon: Icon(Icons.watch)),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Add tags about your museum:',
                        style: TextStyle(color: Color(0xfffa256a)),
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag1 = !flag1),
                              if (flag1)
                                {tags.add('Science')}
                              else if (!flag1)
                                {tags.remove('Science')},
                              print(tags)
                            },
                            child: Text('Science'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag1
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag2 = !flag2),
                              if (flag2)
                                {tags.add('Transport')}
                              else if (!flag2)
                                {tags.remove('Transport')},
                              print(tags)
                            },
                            child: Text('Transport'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag2
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag3 = !flag3),
                              if (flag3)
                                {tags.add('Space')}
                              else if (!flag3)
                                {tags.remove('Space')},
                              print(tags)
                            },
                            child: Text('Space'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag3
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag4 = !flag4),
                              if (flag4)
                                {tags.add('Prehistoric')}
                              else if (!flag4)
                                {tags.remove('Prehistoric')},
                              print(tags)
                            },
                            child: Text('Prehistoric'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag4
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag5 = !flag5),
                              if (flag5)
                                {tags.add('Defense')}
                              else if (!flag5)
                                {tags.remove('Defense')},
                              print(tags)
                            },
                            child: Text('Defense'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag5
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              setState(() => flag6 = !flag6),
                              if (flag6)
                                {tags.add('Others')}
                              else if (!flag6)
                                {tags.remove('Others')},
                              print(tags)
                            },
                            child: Text('Others'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flag6
                                  ? Colors.red
                                  : Colors.teal, // This is what you need!
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: null,
                        minLines: 2,
                        style: TextStyle(color: Colors.white),
                        // obscureText: true,
                        // onSaved: (newValue) => reviews,
                        onChanged: (value) {
                          setState(() {
                            info = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Write a little bit about your museum...",
                          filled: true,
                          fillColor: Color(0xff1a1a1a),
                          labelStyle: TextStyle(color: Color(0xfffa256a)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            save();
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                          child: Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 8, right: 8),
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xfffa256a),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )))
                    ])))
          ],
        ));
  }
}
