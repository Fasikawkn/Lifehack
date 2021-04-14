import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/bloc/bloc.dart';
import 'package:flutter_app/LifeHack/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Adding LifeHackGetRowCount event to know if database table has content 
    // This prevents the life hacks to be inserted into the database everytime the app starts
    // it only inserts the life hacks if database is empty
    LifeHackEvent event = LifeHackGetRowCount();
    BlocProvider.of<LifeHackBloc>(context).add(event);
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
