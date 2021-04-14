import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/bloc/bloc.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/favorite_lifehacks.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_categories.dart';
import 'package:flutter_app/LifeHack/screens/lifehacks_list.dart';
import 'package:flutter_app/LifeHack/screens/my_lifehacks.dart';
import 'package:flutter_app/LifeHack/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _navigateAndDisplayScreen(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LifeHackAddUpdate(
              args: LifeHackArgument(edit: false),
            )));
  final snackBar = SnackBar(content: Text(result));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('message is $result');
  }

  @override
  void initState() {
    super.initState();

    _insertIntoDatabase();
  }

  _insertIntoDatabase() async {
    print("I am creating");
    if (BlocProvider.of<LifeHackBloc>(context).state
        is LifeHackRowCountSuccess) {
      LifeHackRowCountSuccess lifeHackLoadingSuccess =
          BlocProvider.of<LifeHackBloc>(context).state;
      int row = lifeHackLoadingSuccess.row;
      print('row is $row');
      // get the number of rows of the database table to add to the table if only it is empty

      if ((row != null) && (row == 0)) {
        lifehacks.forEach((element) {
          LifeHackEvent event = LifeHackCreate(element);
          BlocProvider.of<LifeHackBloc>(context).add(event);
        });
      }
      // To change the app state to the loading state again
      // This allows the app load the database content.

    }
    LifeHackEvent event = LifeHackLoad();
    BlocProvider.of<LifeHackBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text("LifeHacks"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: List.generate(choices.length, (index) {
              return Center(
                child: SelectedHome(choice: choices[index]),
              );
            })),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[900],
        child: Icon(Icons.add),
        onPressed: () async {
          // final message = Navigator.of(context).pushNamed(
          //     LifeHackAddUpdate.routeName,
          //     arguments: LifeHackArgument(edit: false));
          // print("the message is $message");
          _navigateAndDisplayScreen(context);
        },
      ),
    );
  }
}

class Choice {
  final String title;
  final Icon icon;

  const Choice({this.title, this.icon});
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Home',
      icon: Icon(
        Icons.home,
        size: 40,
        color: Colors.amber,
      )),
  const Choice(
      title: 'Category',
      icon: Icon(Icons.category, size: 40, color: Colors.amber)),
  const Choice(
      title: 'Favorite',
      icon: Icon(Icons.favorite, size: 40, color: Colors.amber)),
  const Choice(
      title: 'My Lifehacks',
      icon: Icon(Icons.person, size: 40, color: Colors.amber)),
  const Choice(
      title: 'Share', icon: Icon(Icons.share, size: 40, color: Colors.amber)),
];

class SelectedHome extends StatelessWidget {
  const SelectedHome({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (choice.title == 'Home') {
          Navigator.of(context).pushNamed(LifeHacks.routeName);
        }
        if (choice.title == 'Category') {
          print("Category");
          Navigator.of(context).pushNamed(LifeHackCategories.routeName);
        }
        if (choice.title == 'Favorite') {
          print("Favorite");
          Navigator.of(context).pushNamed(FavoriteLifeHacks.routeName);
        }
        if (choice.title == 'My Lifehacks') {
          print("Favorite");
          Navigator.of(context).pushNamed(MyLifeHacks.routeName);
        }
        if (choice.title == 'Share') {
          print('Share');
          share(context, 'Hello Every body');
        }
      },
      child: Card(
          child: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: choice.icon),
              Text(choice.title, style: TextStyle(fontSize: 20.0)),
              SizedBox(
                height: 10,
              )
            ]),
      )),
    );
  }
}
