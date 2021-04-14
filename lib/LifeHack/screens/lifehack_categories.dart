import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_category_list.dart';

class LifeHackCategories extends StatelessWidget {
  static const routeName = '/lifeHack/categories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text("Categories"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LifeHacksCategoryList.routeName,
                  arguments: categories[index]['name']);
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/${categories[index]["image"]}'),
                  ),
                  title: Text('${categories[index]['name']}'),
                  trailing: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Text(
                      '${getLifeHackAmount(categories[index]['name'])}',
                      style: TextStyle(
                          fontSize: 6.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
