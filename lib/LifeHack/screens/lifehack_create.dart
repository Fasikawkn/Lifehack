import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LifeHack/bloc/lifehack_event.dart';
import 'package:flutter_app/LifeHack/common/input-decoration.dart';
import 'package:flutter_app/LifeHack/lifehack.dart';
import 'package:flutter_app/LifeHack/screens/home_page.dart';
import 'package:flutter_app/LifeHack/screens/lifehack_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifeHackAddUpdate extends StatefulWidget {
  static const routeName = '/lifehackAddUpdate';
  final LifeHackArgument args;

  LifeHackAddUpdate({this.args});
  @override
  LifeHackAddUpdateState createState() => LifeHackAddUpdateState();
}

class LifeHackAddUpdateState extends State<LifeHackAddUpdate> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _lifeHack = {};
  var _myValue = '';

  final _dataSource = [
    {
      "display": "Economical",
      "value": "Economical",
    },
    {
      "display": "Foods and Drinks",
      "value": "Foods and Drinks",
    },
    {
      "display": "Genius",
      "value": "Genius",
    },
    {
      "display": "Health",
      "value": "Health",
    },
    {
      "display": "Lifetips",
      "value": "Lifetips",
    },
    {
      "display": "Solution",
      "value": "Solution",
    },
    {
      "display": "Technology",
      "value": "Technology",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        title: Text("Add New LifeHack"),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropDownFormField(
                    hintText: 'Select Category',
                    value: widget.args.edit
                        ? widget.args.lifeHack.category
                        : _myValue,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please select category code';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        this._lifeHack['category'] = value;
                        print("lifehack is $_lifeHack");
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myValue = value;
                      });
                    },
                    dataSource: _dataSource,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  initialValue: '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter course code';
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(labelText: 'Tip'),
                  onSaved: (value) {
                    setState(() {
                      print("lifehack is $_lifeHack");
                      this._lifeHack['tip'] = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FlatButton.icon(
                    color: Colors.amber[900],
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        print('content $_lifeHack');
                        form.save();
                        final LifeHackEvent event = LifeHackCreate(
                          LifeHack(
                            category: this._lifeHack["category"],
                            tip: this._lifeHack["tip"],
                            isFaved: 2,
                          ),
                        );

                        BlocProvider.of<LifeHackBloc>(context).add(event);
                        Navigator.of(context).pop("Successfully added!");
                      }
                    },
                    label: Text('SAVE'),
                    icon: Icon(Icons.save),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
