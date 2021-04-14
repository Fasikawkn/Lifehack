import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_detail.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteLifeHacks extends StatefulWidget {
  static const routeName = '/lifehacks/favorite';

  @override
  _FavoriteLifeHacksState createState() => _FavoriteLifeHacksState();
}

class _FavoriteLifeHacksState extends State<FavoriteLifeHacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text('Life Hacks'),
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
              List<LifeHack> favLifeHacks = [];
              lifehacks.forEach((element) {
                if (element.isFaved == 1) {
                  favLifeHacks.add(element);
                }
              });

              return favLifeHacks.length > 0
                  ? ListView.builder(
                      itemCount: favLifeHacks.length,
                      itemBuilder: (context, idx) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage(
                                    'assets/images/${getImageName(favLifeHacks[idx].category)}'),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '${favLifeHacks[idx].category}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              subtitle: Text('${favLifeHacks[idx].tip}'),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    LifeHackDetail.routeName,
                                    arguments: LifeHackDetailArguments(lifeHacks: favLifeHacks, lifeHack: favLifeHacks[idx]));
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("No favorite lifehacks yet!"),
                    );
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
