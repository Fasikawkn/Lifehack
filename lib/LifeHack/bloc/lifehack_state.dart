import 'package:equatable/equatable.dart';
import 'package:flutter_app/LifeHack/model/lifehack.dart';

class LifeHackState extends Equatable {
  const LifeHackState();

  @override
  List<Object> get props => [];
}

class LifeHackLoading extends LifeHackState {
  final int rows;
  LifeHackLoading([this.rows]);
  @override
  List<Object> get props => [rows];
}

class LifeHackLoadingSuccess extends LifeHackState {
  final List<LifeHack> lifeHacks;
  final int rows;
  LifeHackLoadingSuccess([this.lifeHacks = const [], this.rows]);

  @override
  List<Object> get props => [lifeHacks];
}


class LifeHackOperationFailure extends LifeHackState {}

class LifeHackRowCountSuccess extends LifeHackState {
  final int row;

  LifeHackRowCountSuccess([this.row]);

  @override
  List<Object> get props => [row];

}
