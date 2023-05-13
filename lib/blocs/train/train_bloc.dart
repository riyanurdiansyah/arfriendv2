import 'dart:async';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/app_dialog.dart';
part 'train_event.dart';
part 'train_state.dart';

class TrainBloc extends Bloc<TrainEvent, TrainState> {
  final globalKey = GlobalKey<ScaffoldState>();
  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcEmail = TextEditingController();
  final tcPassword = TextEditingController();

  TrainBloc() : super(TrainInitialState()) {
    on<TrainEvent>((event, emit) {});
    on<TrainInitialEvent>(_onInitial);
    on<TrainAddSingleIdEvent>(_onAddSingleId);
    on<TrainAddAllIdEvent>(_onAddAllId);
    on<TrainOnSortingEvent>(_onSorting);
    on<TrainGetDataSetEvent>(_onGetDataset);
    on<TrainOnChangePageEvent>(_onChangePage);
    on<TrainDeleteDataEvent>(_onDeleteData);
  }

  FutureOr<void> _onInitial(
      TrainInitialEvent event, Emitter<TrainState> emit) async {
    add(TrainGetDataSetEvent());
  }

  FutureOr<void> _onAddSingleId(
      TrainAddSingleIdEvent event, Emitter<TrainState> emit) {
    List<String> ids = [];
    for (var cekdata in state.listId) {
      ids.add(cekdata);
    }

    if (ids.contains(event.id)) {
      ids.removeWhere((e) => e == event.id);
    } else {
      ids.add(event.id);
    }
    emit(state.copyWith(listId: ids));
  }

  FutureOr<void> _onAddAllId(
      TrainAddAllIdEvent event, Emitter<TrainState> emit) {
    List<String> ids = [];

    for (var cekdata in state.listId) {
      ids.add(cekdata);
    }

    if (ids.length == state.datasets.length) {
      ids.clear();
    } else {
      ids.clear();
      for (var data in state.datasets) {
        ids.add(data.id);
      }
    }
    emit(state.copyWith(listId: ids));
  }

  FutureOr<void> _onSorting(
      TrainOnSortingEvent event, Emitter<TrainState> emit) {
    List<DatasetEntity> listData = [];
    for (var data in state.datasets) {
      listData.add(data);
    }

    if (state.datasetSorting.isEmpty || state.datasetSorting == "dsc") {
      listData.sort((a, b) => a.title.compareTo(b.title));
      emit(state.copyWith(datasets: listData, datasetSorting: "asc"));
    } else {
      listData.sort((b, a) => a.title.compareTo(b.title));
      emit(state.copyWith(datasets: listData, datasetSorting: "dsc"));
    }
  }

  FutureOr<void> _onGetDataset(
      TrainGetDataSetEvent event, Emitter<TrainState> emit) async {
    final response = await apiService.getDataset();
    response.fold((fail) => emit(TrainFailedLoadDataState(fail.message)),
        (data) {
      double page = 0;
      for (int i = 0; i < data.length; i++) {
        page = (i + 1) / 8;
        data[i] = data[i].copyWith(page: page.ceil());
      }
      emit(state.copyWith(isLoadingSetup: false, datasets: data));
    });
  }

  FutureOr<void> _onChangePage(
      TrainOnChangePageEvent event, Emitter<TrainState> emit) {
    emit(state.copyWith(page: event.page));
  }

  FutureOr<void> _onDeleteData(
      TrainDeleteDataEvent event, Emitter<TrainState> emit) async {
    if (state.listId.isEmpty) {
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!, title: "Silahkan pilih data");
    } else {
      AppDialog.dialogWithActionHapus(
        context: globalKey.currentContext!,
        title: "Hapus Data",
        onTap: () async {
          for (int i = 0; i < state.listId.length; i++) {
            final response = await apiService.deleteDataset(state.listId[i]);
            if ((i + 1) == state.listId.length) {
              response.fold(
                  (l) => AppDialog.dialogNoAction(
                      context: globalKey.currentContext!,
                      title: "Gagal menghapus data"), (r) {
                add(TrainGetDataSetEvent());
                AppDialog.dialogNoAction(
                    context: globalKey.currentContext!,
                    title: "Data berhasil dihapus");
              });
            }
          }
        },
      );
    }
  }
}
