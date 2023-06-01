part of 'train_bloc.dart';

abstract class TrainEvent {}

class TrainInitialEvent extends TrainEvent {}

class TrainClearAllFieldEvent extends TrainEvent {}

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

class TrainSaveTextDataEvent extends TrainEvent {}

class TrainSaveFileDataEvent extends TrainEvent {}

class TrainChooseTragetRoleEvent extends TrainEvent {
  TrainChooseTragetRoleEvent(this.role);

  final String role;
}

class TrainChooseTragetDivisiEvent extends TrainEvent {
  TrainChooseTragetDivisiEvent(this.divisi);

  final String divisi;
}

class TrainChooseFileEvent extends TrainEvent {}

class TrainChooseCsvFileEvent extends TrainEvent {
  TrainChooseCsvFileEvent(this.file);

  final FilePickerResult file;
}

class TrainChooseExceptCsvFileEvent extends TrainEvent {
  TrainChooseExceptCsvFileEvent(this.file);

  final FilePickerResult file;
}

class TrainFromSheetEvent extends TrainEvent {}

class TrainOnTapSourceEvent extends TrainEvent {
  TrainOnTapSourceEvent(this.trainBloc, this.source);
  final TrainBloc trainBloc;
  final String source;
}
