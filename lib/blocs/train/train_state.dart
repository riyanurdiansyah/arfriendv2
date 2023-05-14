part of 'train_bloc.dart';

class TrainState extends Equatable {
  const TrainState({
    this.isLoadingSetup = true,
    this.datasets = const [],
    this.listId = const [],
    this.datasetSorting = "",
    this.page = 1,
    this.targetRole = "",
    this.promptContent = "",
    this.isLoadingProses = false,
  });

  final bool isLoadingSetup;
  final List<DatasetEntity> datasets;
  final List<String> listId;
  final String datasetSorting;
  final int page;
  final String targetRole;
  final String promptContent;
  final bool isLoadingProses;

  TrainState copyWith({
    bool? isLoadingSetup,
    List<DatasetEntity>? datasets,
    List<String>? listId,
    String? datasetSorting,
    int? page,
    String? targetRole,
    String? promptContent,
    bool? isLoadingProses,
  }) =>
      TrainState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        datasets: datasets ?? this.datasets,
        listId: listId ?? this.listId,
        datasetSorting: datasetSorting ?? this.datasetSorting,
        page: page ?? this.page,
        targetRole: targetRole ?? this.targetRole,
        promptContent: promptContent ?? this.promptContent,
        isLoadingProses: isLoadingProses ?? this.isLoadingProses,
      );
  @override
  List<Object?> get props => [
        isLoadingSetup,
        datasets,
        listId,
        datasetSorting,
        page,
        targetRole,
        promptContent,
      ];
}

class TrainInitialState extends TrainState {}

class TrainFailedLoadDataState extends TrainState {
  const TrainFailedLoadDataState(this.errorMessage);

  final String errorMessage;
}

class TrainSuccessLoadDataState extends TrainState {}

class TrainLoadingDataState extends TrainState {}
