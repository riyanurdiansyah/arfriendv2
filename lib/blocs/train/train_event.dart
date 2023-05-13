part of 'train_bloc.dart';

abstract class TrainEvent {}

class TrainInitialEvent extends TrainEvent {}

class TrainAddSingleIdEvent extends TrainEvent {
  TrainAddSingleIdEvent(this.id);

  final String id;
}

class TrainAddAllIdEvent extends TrainEvent {}

class TrainOnSortingEvent extends TrainEvent {}

class TrainGetDataSetEvent extends TrainEvent {}

class TrainOnChangePageEvent extends TrainEvent {
  TrainOnChangePageEvent(this.page);

  final int page;
}

class TrainDeleteDataEvent extends TrainEvent {}
