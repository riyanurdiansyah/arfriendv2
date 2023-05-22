import 'dart:async';
import 'dart:convert';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../utils/app_dialog.dart';
part 'train_event.dart';
part 'train_state.dart';

class TrainBloc extends Bloc<TrainEvent, TrainState> {
  final globalKey = GlobalKey<ScaffoldState>();
  final textKey = GlobalKey<FormState>();
  final fileKey = GlobalKey<FormState>();
  final sheetKey = GlobalKey<FormState>();

  final FirebaseApiService apiService = FirebaseApiServiceImpl();
  final tcTitle = TextEditingController();
  final tcTitleFile = TextEditingController();
  final tcDetail = TextEditingController();
  final tcFile = TextEditingController();

  final tcSheetID = TextEditingController();
  final tcSheetName = TextEditingController();
  final tcTitleSheet = TextEditingController();

  TrainBloc() : super(TrainInitialState()) {
    on<TrainEvent>((event, emit) {});
    on<TrainInitialEvent>(_onInitial);
    on<TrainAddSingleIdEvent>(_onAddSingleId);
    on<TrainAddAllIdEvent>(_onAddAllId);
    on<TrainOnSortingEvent>(_onSorting);
    on<TrainGetDataSetEvent>(_onGetDataset);
    on<TrainOnChangePageEvent>(_onChangePage);
    on<TrainDeleteDataEvent>(_onDeleteData);
    on<TrainSaveTextDataEvent>(_onSaveTextData);
    on<TrainChooseFileEvent>(_onChooseFile);
    on<TrainChooseCsvFileEvent>(_onChooseCsvFile);
    on<TrainChooseDocFileEvent>(_onChooseDocFile);
    on<TrainSaveFileDataEvent>(_onSaveFileData);
    on<TrainChooseTragetRoleEvent>(_onChooseTargetRole);
    on<TrainClearAllFieldEvent>(_onClearAllField);
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
                emit(state.copyWith(listId: []));
              });
            }
          }
        },
      );
    }
  }

  FutureOr<void> _onSaveTextData(
      TrainSaveTextDataEvent event, Emitter<TrainState> emit) async {
    var uuid = const Uuid().v4();

    final body = {
      "id": uuid,
      "title": tcTitle.text,
      "type": "text",
      "addedBy": FirebaseAuth.instance.currentUser!.email!,
      "to": state.targetRole,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
      "messages": {
        "role": "user",
        "content": tcDetail.text,
        "hidden": true,
      }
    };

    final response = await apiService.saveDataset(body);
    response.fold(
        (l) => AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Gagal manambahkan data"), (r) {
      add(TrainGetDataSetEvent());
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Data berhasil ditambahkan");
    });
  }

  FutureOr<void> _onChooseFile(
      TrainChooseFileEvent event, Emitter<TrainState> emit) async {
    var result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["csv", "doc", "docx", "pdf"],
      type: FileType.custom,
      allowMultiple: false,
    );

    if (result != null) {
      tcFile.text = result.files.first.name;
      if (result.files.first.name.contains("doc")) {
        add(TrainChooseDocFileEvent(result));
      }
      if (result.files.first.name.contains("csv")) {
        add(TrainChooseCsvFileEvent(result));
      }
    }
  }

  FutureOr<void> _onChooseDocFile(
      TrainChooseDocFileEvent event, Emitter<TrainState> emit) {}

  FutureOr<void> _onChooseCsvFile(
      TrainChooseCsvFileEvent event, Emitter<TrainState> emit) {
    final bytes = utf8.decode(event.file.files.first.bytes!);
    List<List<dynamic>> rows = const CsvToListConverter().convert(bytes);
    List<dynamic> headers = rows[0];
    String template = "Ada data ${tcTitleFile.text} terdiri dari ";

    for (int i = 0; i < headers.length; i++) {
      if (i + 1 == headers.length) {
        template =
            "$template dan ${headers[i].toString()}. isi data dipisah dengan , dan tiap baris dipisah dengan # ";
      } else {
        template = "${template + headers[i].toString()},";
      }
    }

    List<Map<String, dynamic>> listData = rows.map((list) {
      Map<String, dynamic> map = {};
      for (int i = 0; i < headers.length; i++) {
        map[headers[i]] = list[i];
      }
      return map;
    }).toList();

    listData.removeAt(0);

    List<String> hasilListString = listData
        .map((map) => map.values.map((value) => value.toString()).join(', '))
        .toList();
    String hasilAkhir = hasilListString.join(' # ');

    emit(state.copyWith(promptContent: template + hasilAkhir));
  }

  FutureOr<void> _onSaveFileData(
      TrainSaveFileDataEvent event, Emitter<TrainState> emit) async {
    if (state.promptContent.isEmpty) {
      add(TrainClearAllFieldEvent());
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!, title: "Silahkan upload file");
    } else if (state.targetRole.isEmpty) {
      add(TrainClearAllFieldEvent());
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Silahkan pilih target role");
    } else {
      emit(state.copyWith(isLoadingProses: !state.isLoadingProses));
      var uuid = const Uuid().v4();

      // final prompt = {
      //   "konteks": tcTitleFile.text,
      //   "respons": state.promptContent,
      // };

      final data = {
        "id": uuid,
        "title": tcTitleFile.text,
        "type": "file",
        "addedBy": FirebaseAuth.instance.currentUser!.email!,
        "to": state.targetRole,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
        "messages": {
          "role": "user",
          "content": state.promptContent,
          "hidden": true,
        }
      };

      final response = await apiService.saveDataset(data);
      response.fold((fail) {
        emit(state.copyWith(isLoadingProses: false));
        return AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Ooppss... terjadi kesalahan diserver. silahkan coba lagi");
      }, (r) {
        emit(state.copyWith(isLoadingProses: false));
        add(TrainGetDataSetEvent());
        add(TrainClearAllFieldEvent());
        return AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil ditambahkan");
      });
    }
  }

  FutureOr<void> _onChooseTargetRole(
      TrainChooseTragetRoleEvent event, Emitter<TrainState> emit) {
    emit(state.copyWith(targetRole: event.role));
  }

  FutureOr<void> _onChooseDivisi(
      TrainChooseTragetDivisiEvent event, Emitter<TrainState> emit) {
    emit(state.copyWith(targetDivisi: event.divisi));
  }

  FutureOr<void> _onClearAllField(
      TrainClearAllFieldEvent event, Emitter<TrainState> emit) {
    tcDetail.clear();
    tcFile.clear();
    tcTitle.clear();
    tcTitleFile.clear();
    emit(state.copyWith(targetRole: "", listId: [], promptContent: ""));
  }
}
