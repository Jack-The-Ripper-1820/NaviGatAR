import 'package:flutter/widgets.dart';
import 'package:frontend/screens/register_museum.dart';
import 'package:frontend/screens/signup.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/sign_in/sign_in.dart';
import 'screens/home.dart';


final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignUp.routeName: (_)=>SignUp(),
  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home(),
};
