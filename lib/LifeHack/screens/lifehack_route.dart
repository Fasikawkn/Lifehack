import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/screens/favorite_lifehacks.dart';
import 'package:flutter_app/LifeHack/screens/home_page.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_categories.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_category_list.dart';
import 'package:flutter_app/LifeHack/screens/my_lifehacks.dart';
import 'package:flutter_app/LifeHack/screens/screens.dart';
import 'package:flutter_app/LifeHack/screens/splash_screen.dart';

import '../lifehack.dart';

class LifeHackAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => SplashScreen());
    }
    if (settings.name == LifeHackAddUpdate.routeName) {
      final args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => LifeHackAddUpdate(
                args: args,
              ));
    }
    if (settings.name == LifeHackDetail.routeName) {
      LifeHackDetailArguments lifeHack = settings.arguments;
      print("lifehack router ${lifeHack.lifeHacks[0].id}");
      return MaterialPageRoute(
          builder: (context) => LifeHackDetail(
                arguments: lifeHack,
              ));
    }
    if (settings.name == LifeHacks.routeName) {
      return MaterialPageRoute(builder: (context) => LifeHacks());
    }
    if (settings.name == FavoriteLifeHacks.routeName) {
      return MaterialPageRoute(builder: (context) => FavoriteLifeHacks());
    }
    if (settings.name == LifeHackCategories.routeName) {
      return MaterialPageRoute(builder: (context) => LifeHackCategories());
    }
    if (settings.name == LifeHacksCategoryList.routeName) {
      final args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => LifeHacksCategoryList(
                category: args,
              ));
    }
    if (settings.name == MyLifeHacks.routeName) {
      final args = settings.arguments;
      return MaterialPageRoute(builder: (context) => MyLifeHacks());
    }
    if (settings.name == HomePage.routeName) {
      return MaterialPageRoute(builder: (context) => HomePage());
    }
  }
}

class LifeHackArgument {
  final LifeHack lifeHack;
  final bool edit;

  LifeHackArgument({this.lifeHack, this.edit});
}

class LifeHackDetailArguments {
  final LifeHack lifeHack;
  final List<LifeHack> lifeHacks;

  LifeHackDetailArguments({this.lifeHack, this.lifeHacks});
}
