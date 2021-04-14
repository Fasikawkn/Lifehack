import 'package:flutter/cupertino.dart';
import 'package:flutter_app/LifeHack/bloc/lifehack_event.dart';
import 'package:flutter_app/LifeHack/bloc/lifehack_state.dart';
import 'package:flutter_app/LifeHack/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifeHackBloc extends Bloc<LifeHackEvent, LifeHackState> {
  final LifeHackRepository lifeHackRepository;

  LifeHackBloc({@required this.lifeHackRepository})
      : assert(lifeHackRepository != null),
        super(LifeHackLoading());

  @override
  Stream<LifeHackState> mapEventToState(LifeHackEvent event) async* {
    if (event is LifeHackGetRowCount) {
      try {
        final rows = await lifeHackRepository.getRowCount();
        yield LifeHackRowCountSuccess(rows);
      } catch (e) {
        yield LifeHackOperationFailure();
      }
    }
    
    if (event is LifeHackLoad) {
      final rows = await lifeHackRepository.getRowCount();
      yield LifeHackLoading(rows);
      try {
        final rows = await lifeHackRepository.getRowCount();
        final lifeHacks = await lifeHackRepository.getAllLifeHacks();
        yield LifeHackLoadingSuccess(lifeHacks, rows);
      } catch (_) {
        yield LifeHackOperationFailure();
      }
    }

    if (event is LifeHackCreate) {
      try {
        await lifeHackRepository.addLifeHack(event.lifeHack);
        final lifeHacks = await lifeHackRepository.getAllLifeHacks();
        yield LifeHackLoadingSuccess(lifeHacks);
      } catch (e) {
        print("opration error $e");
        yield LifeHackOperationFailure();
      }
    }

    if (event is LifeHackUpdate) {
      try {
        await lifeHackRepository.updateLifeHack(event.lifeHack);
        final lifeHacks = await lifeHackRepository.getAllLifeHacks();
        yield LifeHackLoadingSuccess(lifeHacks);
      } catch (e) {
        print("Operation error $e");
        yield LifeHackOperationFailure();
      }
    }

    if (event is LifeHackDelete) {
      try {
        await lifeHackRepository.deleteLifeHack(event.lifeHack.id);
        final lifeHacks = await lifeHackRepository.getAllLifeHacks();
        yield LifeHackLoadingSuccess(lifeHacks);
      } catch (e) {
        print('Delete error $e');
        yield LifeHackOperationFailure();
      }
    }

    
  }
}
