import 'package:equatable/equatable.dart';
import 'package:flutter_app/LifeHack/model/lifehack.dart';

// The parent event that we will create on the app
abstract class LifeHackEvent extends Equatable {
  const LifeHackEvent();
}


class LifeHackLoad extends LifeHackEvent {
  const LifeHackLoad();

  @override
  List<Object> get props => [];
}

class LifeHackCreate extends LifeHackEvent {
  final LifeHack lifeHack;

  const LifeHackCreate(this.lifeHack);

  @override
  List<Object> get props => [lifeHack];

  @override
  String toString() => 'LifeHack Created {lifeHack: $lifeHack}';
}

class LifeHackUpdate extends LifeHackEvent {
  final LifeHack lifeHack;

  const LifeHackUpdate(this.lifeHack);

  @override
  List<Object> get props => [lifeHack];

  @override
  String toString() => 'LifeHack Updated {lifeHack: $lifeHack}';
}

class LifeHackDelete extends LifeHackEvent {
  final LifeHack lifeHack;

  const LifeHackDelete(this.lifeHack);

  @override
  List<Object> get props => [lifeHack];

  @override
  toString() => 'LifeHack Deleted {lifeHack: $lifeHack}';
}


class LifeHackGetRowCount extends LifeHackEvent {
 

  LifeHackGetRowCount();

   @override
  List<Object> get props => [];

}
