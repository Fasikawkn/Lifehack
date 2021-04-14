import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_create.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_detail.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifeHacks extends StatefulWidget {
  static const routeName = '/lifehacks';

  @override
  _LifeHacksState createState() => _LifeHacksState();
}

class _LifeHacksState extends State<LifeHacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text('All Lifehacks'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
        child: BlocBuilder<LifeHackBloc, LifeHackState>(
          builder: (_, state) {
            if (state is LifeHackOperationFailure) {
              return Text('Could not do lifehack operation');
            }
            if (state is LifeHackLoadingSuccess) {
              
              List<LifeHack> lifehacks = [];
              state.lifeHacks.forEach((element) {
                if (element.id < 10) {
                  lifehacks.add(element);
                }
              });
              return ListView.builder(
                itemCount: lifehacks.length,
                itemBuilder: (context, idx) {
                  print("id is ${lifehacks[idx].id}");

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage(
                              'assets/images/${getImageName(lifehacks[idx].category)}'),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '${lifehacks[idx].category}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        subtitle: Text('${lifehacks[idx].tip}'),
                        onTap: () {
                          
                          Navigator.of(context).pushNamed(
                              LifeHackDetail.routeName,
                              arguments: LifeHackDetailArguments(lifeHack: lifehacks[idx], lifeHacks: lifehacks));
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
