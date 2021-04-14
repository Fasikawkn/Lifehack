import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:share/share.dart';

List<LifeHack> lifehacks = [
  LifeHack(
      isFaved: 2,
      category: "Technology",
      tip:
          ''' To quickly change the case (upper vs. lower) of text in Microsoft Word, highlight the phrase, then hit Shift + F3. Changes cycle through all lowercase, first letter capitalized, and all in uppercase. '''),
  LifeHack(
      isFaved: 2,
      category: "Genius",
      tip: '''Wrap the handles of bananas in foil for fresh storage
        '''),
  LifeHack(
      isFaved: 2,
      category: "Health",
      tip: '''Wrap the handles of bananas in foil for fresh storage
        '''),
  LifeHack(
      isFaved: 2,
      category: "Life Tips",
      tip: '''Wrap the handles of bananas in foil for fresh storage
        '''),
  LifeHack(
      isFaved: 2,
      category: 'Genius',
      tip: 'Install a rolling recycling bin in your kitchen'),
  LifeHack(
      isFaved: 2,
      category: 'Economical',
      tip: 'Drink water as your primary or exclusive beverage.'),
  LifeHack(
      isFaved: 2,
      category: 'Economical',
      tip: 'If you can’t handle your tap water, get a water filter.'),
  LifeHack(
      isFaved: 2,
      category: 'Solution',
      tip: 'Call your auto insurance company.'),
  LifeHack(
      isFaved: 2,
      category: 'Foods and Drinks',
      tip:
          '''Half-eaten bag 'o chips and nary a chip clip in sight? Check out this folding technique for keeping snacks fresh and the bag closed, no hardware required.'''),
];

List<Map<String, String>> categories = [
  {'name': "Economical", 'image': 'economy.jpg'},
  {'name': "Foods and Drinks", 'image': 'foods_and_drinks.png'},
  {'name': "Genius", 'image': 'brain.png'},
  {'name': "Health", 'image': 'health.png'},
  {'name': "Life Tips", 'image': 'Life_tips.png'},
  {'name': "Solution", 'image': 'solution.png'},
  {'name': "Technology", 'image': 'technology.png'},
];

String getImageName(String category) {
  if (category.toLowerCase() == 'Economical'.toLowerCase()) {
    return 'economy.jpg';
  } else if (category.toLowerCase() == 'Foods and Drinks'.toLowerCase()) {
    return 'foods_and_drinks.png';
  } else if (category.toLowerCase() == 'Genius'.toLowerCase()) {
    return 'brain.png';
  } else if (category.toLowerCase() == 'Health'.toLowerCase()) {
    return 'health.png';
  } else if (category.toLowerCase() == 'Life Tips'.toLowerCase()) {
    return 'Life_tips.png';
  } else if (category.toLowerCase() == 'Solution'.toLowerCase()) {
    return 'solution.png';
  } else if (category.toLowerCase() == 'Technology'.toLowerCase()) {
    return 'technology.png';
  } else {
    return 'solution.png';
  }
}

int getLifeHackAmount(String category) {
  int count = 0;
  lifehacks.forEach((element) {
    if (element.category == category) {
      count++;
    }
  });

  return count;
}

void share(BuildContext context, String content) {
  final RenderBox box = context.findRenderObject();

  Share.share(
    content,
    subject: 'share my item',
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}