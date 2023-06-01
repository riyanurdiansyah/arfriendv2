part of 'train_bloc.dart';

class TrainState extends Equatable {
  const TrainState({
    this.isLoadingSetup = true,
    this.datasets = const [],
    this.listId = const [],
    this.datasetSorting = "",
    this.page = 1,
    this.targetRole = "",
    this.targetDivisi = "",
    this.targetCategory = "",
    this.promptContent = "",
    this.isLoadingProses = false,
    this.isAdd = false,
    this.source = "file",
  });

  final bool isLoadingSetup;
  final List<DatasetEntity> datasets;
  final List<String> listId;
  final String datasetSorting;
  final int page;
  final String targetRole;
  final String targetDivisi;
  final String targetCategory;
  final String promptContent;
  final bool isLoadingProses;
  //baru
  final bool isAdd;
  final String source;

  TrainState copyWith({
    bool? isLoadingSetup,
    List<DatasetEntity>? datasets,
    List<String>? listId,
    String? datasetSorting,
    int? page,
    String? targetRole,
    String? targetDivisi,
    String? targetCategory,
    String? promptContent,
    bool? isLoadingProses,
    bool? isAdd,
    String? source,
  }) =>
      TrainState(
        isLoadingSetup: isLoadingSetup ?? this.isLoadingSetup,
        datasets: datasets ?? this.datasets,
        listId: listId ?? this.listId,
        datasetSorting: datasetSorting ?? this.datasetSorting,
        page: page ?? this.page,
        targetRole: targetRole ?? this.targetRole,
        targetDivisi: targetDivisi ?? this.targetDivisi,
        targetCategory: targetCategory ?? this.targetCategory,
        promptContent: promptContent ?? this.promptContent,
        isLoadingProses: isLoadingProses ?? this.isLoadingProses,
        isAdd: isAdd ?? this.isAdd,
        source: source ?? this.source,
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
        targetDivisi,
        targetRole,
        isAdd,
        source,
      ];
}

class TrainInitialState extends TrainState {}

class TrainFailedLoadDataState extends TrainState {
  const TrainFailedLoadDataState(this.errorMessage);

  final String errorMessage;
}

class TrainSuccessLoadDataState extends TrainState {}

class TrainLoadingDataState extends TrainState {}
