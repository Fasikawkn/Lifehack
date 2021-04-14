import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/common/lifehacks_contents.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/home_page.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

class LifeHackDetail extends StatefulWidget {
  static final routeName = '/lifehack/detail';

  final LifeHackDetailArguments arguments;
  LifeHackDetail({this.arguments});

  @override
  _LifeHackDetailState createState() => _LifeHackDetailState();
}

class _LifeHackDetailState extends State<LifeHackDetail> {
  int counter = 12;
  Color color = Colors.white;
  bool isFaved;
  LifeHack lifeHack;
  int index;
  bool isNextDisabled = false;
  bool isPreviousDisabled = false;

  _setNextDisabled() {
    isNextDisabled = !isNextDisabled;
  }

  _setPreviousDisabled() {
    isPreviousDisabled = !isPreviousDisabled;
  }

  Future<void> _copyToClipboard(text) async {
    await Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(content: Text('Copied to clipboard'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    ;
  }

  @override
  void initState() {
    super.initState();
    lifeHack = widget.arguments.lifeHack;
    color = lifeHack.isFaved == 1 ? Colors.pink : Colors.white;
    widget.arguments.lifeHacks.forEach((element) {
      if (element.id == lifeHack.id) {
        index = widget.arguments.lifeHacks.indexOf(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if ((index >= 0) && (index < widget.arguments.lifeHacks.length)) {
      lifeHack = widget.arguments.lifeHacks[index];
    }

    // color = lifeHack.isFaved == 1 ? Colors.pink : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text("LifeHack"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _copyToClipboard(lifeHack.tip);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    share(context, lifeHack.tip);
                  }),
              IconButton(
                  icon: Icon(Icons.favorite, color: color),
                  onPressed: () {
                    LifeHackEvent event = lifeHack.isFaved == 1
                        ? LifeHackUpdate(
                            LifeHack(
                              id: lifeHack.id,
                              category: lifeHack.category,
                              tip: lifeHack.tip,
                              isFaved: 2,
                            ),
                          )
                        : LifeHackUpdate(
                            LifeHack(
                              id: lifeHack.id,
                              category: lifeHack.category,
                              tip: lifeHack.tip,
                              isFaved: 1,
                            ),
                          );
                    BlocProvider.of<LifeHackBloc>(context).add(event);

                    setState(() {
                      if (color == Colors.white) {
                        color = Colors.pink;
                      } else {
                        color = Colors.white;
                      }
                    });
                  }),
              lifeHack.id > 9
                  ? IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        LifeHackEvent event = LifeHackDelete(lifeHack);
                        BlocProvider.of<LifeHackBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomePage.routeName, (route) => false);
                      },
                    )
                  : SizedBox(),
              SizedBox(
                width: 40.0,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/${getImageName(lifeHack.category)}'),
                radius: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '${lifeHack.category}',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                child: Text(
                  '${lifeHack.tip}',
                  style: TextStyle(
                      fontFamily: 'RobotoMono',
                      wordSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isPreviousDisabled | (index == 0)
                ? Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: FloatingActionButton(
                        heroTag: null,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                        ),
                        backgroundColor: Colors.grey,
                        onPressed: () {}),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.amber[900]),
                      onPressed: () {
                        setState(() {
                          print(
                              "length is ${widget.arguments.lifeHacks.length}");
                          if (index > 0) {
                            index--;
                            if (index == widget.arguments.lifeHacks.length) {
                              _setNextDisabled();
                            }
                          } else {
                            _setPreviousDisabled();
                          }
                          print("index updated $index");
                        });
                      },
                    ),
                  ),
            isNextDisabled | (index == widget.arguments.lifeHacks.length - 1)
                ? FloatingActionButton(
                    heroTag: null,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    backgroundColor: Colors.grey,
                    onPressed: () {})
                : FloatingActionButton(
                    heroTag: null,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.amber[900],
                    ),
                    onPressed: () {
                      print("length next is ${index}");
                      if (index <= widget.arguments.lifeHacks.length) {
                        setState(() {
                          index++;
                          if (index == 0) {
                            _setPreviousDisabled();
                          }
                        });
                      } else {
                        _setNextDisabled();
                      }
                      print("index updated $index");
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
