import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class LifeHack extends Equatable {
  final int id;
  final String category;
  final String tip;
  final int isFaved;

  LifeHack({this.id, this.category, this.tip, this.isFaved});
  Map<String, dynamic> toMap() =>
      {'id': id, 'category': category, 'tip': tip, 'isFaved': isFaved};

  @override
  List<Object> get props => [this.category, this.tip, this.isFaved];

  factory LifeHack.fromJson(Map<String, dynamic> json) {
    return LifeHack(
        id: json['id'],
        category: json['category'],
        tip: json['tip'],
        isFaved: json['isFaved']);
  }

  
}
