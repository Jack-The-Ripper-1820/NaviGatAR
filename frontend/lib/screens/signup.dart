import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/register_museum.dart';
import 'package:frontend/screens/sign_in/sign_in.dart';
import 'package:hive/hive.dart';

import '../components/default_button.dart';
import '../components/form_error.dart';
import '../models/Sign_in_res.dart';
import 'home.dart';

final dio = Dio();

class SignUp extends StatefulWidget {
 static String routeName = '/sign_up';
  SignUp({Key? key}) : super(key: key);
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? lname;
  String? fname;
  final List<String?> errors = [];

  Future<void> submit(role) async {
  await register(role);
  await login(role);
}

  Future<void> register(role) async {
    var params = {
      "email": email,
      "password": password,
      "firstName": fname,
      "lastName": lname,
    };
    await dio.post('$apiUrl/api/${role == 'STUDENT' ? 'tourist' : 'museumOwner'}/register',
        data: jsonEncode(params));
  }

  Future<void> login(role) async {
    var params = {"email": email, "password": password};
    Response response =
    await dio.post('$apiUrl/api/${role == 'STUDENT' ? 'tourist' : 'museumOwner'}/login', data: jsonEncode(params));
    Details det = Details.fromJson(response.data);
    final user = Hive.box("user");
    user.put('id', det.userData!.id);
    user.put('token', det.userData!.token);
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final role = arguments['role'];
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          children: [
            Container(
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                child: Column(children: [
                  Text('Hello, there!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600)),
                  Text('Sign up as a ${role == 'STUDENT' ? 'student': 'owner'}',
                      style: TextStyle(
                          color: Color(0xff1ce0e2),
                          fontSize: 15,
                          fontWeight: FontWeight.w400))
                ])),
            SizedBox(height: 50),
            Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    // obscureText: true,
                    onSaved: (newValue) => email = newValue,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        removeError(error: kEmailNullError);
                      } else if (emailValidatorRegExp.hasMatch(value)) {
                        removeError(error: kInvalidEmailError);
                      }
                      setState(() {
                        email = value;
                      });
                      return null;
                    },
                    validator: (value) {
                      removeError(error: kInvalidEmailError);
                      removeError(error: kEmailNullError);
                      if (value!.isEmpty) {
                        addError(error: kEmailNullError);
                        return "";
                      } else if (!emailValidatorRegExp.hasMatch(value)) {
                        addError(error: kInvalidEmailError);
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Email Id",
                        filled: true,
                        fillColor: Color(0xff1a1a1a),
                        labelStyle: TextStyle(color: Color(0xfffa256a)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        suffixIcon: Icon(Icons.mail)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      onSaved: (newValue) => email = newValue,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: kPassNullError);
                        } else if (value.length >= 8) {
                          removeError(error: kShortPassError);
                        }
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        removeError(error: kPassNullError);
                        removeError(error: kShortPassError);
                        if (value!.isEmpty) {
                          addError(error: kPassNullError);
                          return "";
                        } else if (value.length < 8) {
                          addError(error: kShortPassError);
                          return "";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Color(0xff1a1a1a),
                          labelStyle: TextStyle(color: Color(0xfffa256a)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          suffixIcon: Icon(Icons.lock)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      onSaved: (newValue) => email = newValue,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          removeError(error: kFirstNameNullError);
                        }
                        setState(() {
                          fname = value;
                        });
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          addError(error: kFirstNameNullError);
                          return '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "First Name",
                          filled: true,
                          fillColor: Color(0xff1a1a1a),
                          labelStyle: TextStyle(color: Color(0xfffa256a)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          suffixIcon: Icon(Icons.text_fields_outlined)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      onSaved: (newValue) => email = newValue,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          removeError(error: kLastNameNullError);
                        }
                        setState(() {
                          fname = value;
                        });
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          addError(error: kLastNameNullError);
                          return '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          filled: true,
                          fillColor: Color(0xff1a1a1a),
                          labelStyle: TextStyle(color: Color(0xfffa256a)),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          suffixIcon: Icon(Icons.text_fields)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FormError(errors: errors),
                  SizedBox(
                    height: 30,
                  ),
                  DefaultButton(
                    text: "Submit",
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await submit(role);
                        if(role == 'OWNER') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterMuseum()));
                        } else {
                          Navigator.pushNamed(context, Home.routeName);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Container(
                        child: Text("Already have an account? Sign in now",
                            style: TextStyle(
                                color: Color(
                                  0xfffa256a,
                                ),
                                fontSize: 15))),
                  ),
                ]))
          ],
        ));
  }
}
