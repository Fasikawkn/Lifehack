import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_create.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_detail.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLifeHacks extends StatefulWidget {
  static const routeName = '/lifehacks/mylifehacks';

  @override
  _MyLifeHacksState createState() => _MyLifeHacksState();
}

class _MyLifeHacksState extends State<MyLifeHacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text('My Lifehacks'),
        
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
        child: BlocBuilder<LifeHackBloc, LifeHackState>(
          builder: (_, state) {
            if (state is LifeHackOperationFailure) {
              return Text('Could not do lifehack operation');
            }

            if (state is LifeHackLoadingSuccess) {
              final lifehacks = state.lifeHacks;
              List<LifeHack> myLifehacks = [];
              lifehacks.forEach((element) {
                if (element.id > 9) {
                  myLifehacks.add(element);
                }
              });

              return myLifehacks.length > 0
                  ? ListView.builder(
                      itemCount: myLifehacks.length,
                      itemBuilder: (context, idx) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage(
                                    'assets/images/${getImageName(myLifehacks[idx].category)}'),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '${myLifehacks[idx].category}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              subtitle: Text('${myLifehacks[idx].tip}'),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    LifeHackDetail.routeName,
                                    arguments: LifeHackDetailArguments(lifeHacks: myLifehacks, lifeHack: myLifehacks[idx]));
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("you have no lifehacks yet!"),
                    );
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
