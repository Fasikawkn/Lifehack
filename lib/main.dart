import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final LifeHackRepository repository =
      LifeHackRepository(databaseHelper: DatabaseHelper.instance);
  runApp(LifeHackApp(lifeHackRepository: repository,));
}

class LifeHackApp extends StatefulWidget {
  final LifeHackRepository lifeHackRepository;

  LifeHackApp({@required this.lifeHackRepository})
      : assert(lifeHackRepository != null);
  @override
  _LifeHackAppState createState() => _LifeHackAppState();
}
class _LifeHackAppState extends State<LifeHackApp> {

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.widget.lifeHackRepository,
      child: BlocProvider(
        create: (context) => LifeHackBloc(lifeHackRepository: this.widget.lifeHackRepository)
          ..add(LifeHackLoad(),
          
          ),
        child: MaterialApp(
          title: 'Lifehack App',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: LifeHackAppRoute.generateRoute,
        ),
      ),
    );
  }
}
