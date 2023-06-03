import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:arfriendv2/api/firebase_service.dart';
import 'package:arfriendv2/api/firebase_service_impl.dart';
import 'package:arfriendv2/entities/dataset/dataset_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uuid/uuid.dart';

import '../../utils/app_constanta.dart';
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

  final tcSheetLink = TextEditingController();
  final tcSheetID = TextEditingController();
  final tcSheetName = TextEditingController();
  final tcTitleSheet = TextEditingController();

  String apiKey = "";

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
    on<TrainChooseExceptCsvFileEvent>(_onChooseExceptCsvFile);
    on<TrainSaveFileDataEvent>(_onSaveFileData);
    on<TrainChooseTragetRoleEvent>(_onChooseTargetRole);
    on<TrainClearAllFieldEvent>(_onClearAllField);
    on<TrainChooseTragetDivisiEvent>(_onChooseDivisi);
    on<TrainFromSheetEvent>(_onTrainFromSheet);
    on<TrainOnTapSourceEvent>(_onTapSource);
    on<TrainOnAddEvent>(_onAdd);
    on<TrainOnUnggahDataEvent>(_onTranUnggahData);
    on<TrainOnCheckTokenGPTEvent>(_onCheckToken);
  }

  FutureOr<void> _onInitial(
      TrainInitialEvent event, Emitter<TrainState> emit) async {
    final data = (await FirebaseFirestore.instance
        .collection("config")
        .doc("configs")
        .get());
    apiKey = data.data()!["api_key"];
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
                add(TrainClearAllFieldEvent());
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
    AppDialog.dialogLoading(context: globalKey.currentContext!);
    var uuid = const Uuid().v4();

    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    final resToken = await apiService.checkTokenPrompt(headers, tcDetail.text);

    resToken.fold((l) => globalKey.currentContext!.pop(), (token) async {
      final body = {
        "id": uuid,
        "title": tcTitle.text,
        "type": "text",
        "token": token,
        "addedBy": FirebaseAuth.instance.currentUser!.email!,
        "to": state.targetRole,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
        "messages": {
          "role": "system",
          "content": tcDetail.text,
          "hidden": true,
          "date": DateTime.now().toIso8601String(),
        }
      };

      final response = await apiService.saveDataset(body);
      response.fold(
          (l) => AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: "Gagal manambahkan data"), (r) {
        add(TrainGetDataSetEvent());
        globalKey.currentContext!.pop();
        AppDialog.dialogNoAction(
            context: globalKey.currentContext!,
            title: "Data berhasil ditambahkan");
      });
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
      if (result.files.first.name.contains("csv")) {
        add(TrainChooseCsvFileEvent(result));
      } else {
        add(TrainChooseExceptCsvFileEvent(result));
      }
    }
  }

  FutureOr<void> _onChooseExceptCsvFile(
      TrainChooseExceptCsvFileEvent event, Emitter<TrainState> emit) async {
    // emit(state.copyWith(isLoadingProses: !state.isLoadingProses));
    final response = await uploadFile(event.file);
    emit(state.copyWith(promptContent: "Data ${tcTitleFile.text}: $response"));
  }

  Future<String> uploadFile(FilePickerResult result) async {
    PlatformFile filex = result.files.first;
    Uint8List fileData = filex.bytes!;
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref().child("train/${result.files.first.name}");

    return storageRef.putData(fileData).then((_) {
      print('File uploaded successfully.');
      return storageRef.getDownloadURL().then((url) {
        print('Download URL: $url');
        return url;
      });
    }).catchError((error) {
      print('Error uploading file: $error');
      return "";
    });
  }

  FutureOr<void> _onChooseCsvFile(
      TrainChooseCsvFileEvent event, Emitter<TrainState> emit) async {
    AppDialog.dialogLoading(
        context: globalKey.currentContext!,
        text: "Mengunggah\nMohon tunggu yaa...");

    await uploadFile(event.file).then((link) {
      globalKey.currentContext!.pop();
      final bytes = utf8.decode(event.file.files.first.bytes!);
      List<List<dynamic>> rows = const CsvToListConverter().convert(bytes);
      List<dynamic> headers = rows[0];

      List<Map<String, dynamic>> listData = rows.map((list) {
        Map<String, dynamic> map = {};
        for (int i = 0; i < headers.length; i++) {
          map[headers[i]] = list[i];
        }
        return map;
      }).toList();

      listData.removeAt(0);

      String jsonLines = listData.map((map) => jsonEncode(map)).join('.');
      emit(state.copyWith(
          urlFile: link,
          promptContent: jsonLines
              .replaceAll("{", "")
              .replaceAll("}", "")
              .replaceAll('"', "")));
      // return;
    });
  }

  FutureOr<void> _onSaveFileData(
      TrainSaveFileDataEvent event, Emitter<TrainState> emit) async {
    if (state.promptContent.isEmpty) {
      add(TrainClearAllFieldEvent());
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!, title: "Silahkan upload file");
    }
    // else if (state.targetRole.isEmpty) {
    //   add(TrainClearAllFieldEvent());
    //   AppDialog.dialogNoAction(
    //       context: globalKey.currentContext!,
    //       title: "Silahkan pilih target role");
    // }
    else {
      // emit(state.copyWith(isLoadingProses: !state.isLoadingProses));
      AppDialog.dialogLoading(context: globalKey.currentContext!);
      var uuid = const Uuid().v4();

      String prompt =
          "konteks: ${tcTitle.text}. respons: ${state.promptContent}";
      final headers = {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      };

      final resToken = await apiService.checkTokenPrompt(headers, prompt);
      resToken.fold((l) => globalKey.currentContext!.pop(), (token) async {
        globalKey.currentContext!.pop();
        final data = {
          "id": uuid,
          "title": tcTitle.text,
          "type": "file",
          "token": token,
          "urlFile": state.urlFile,
          "addedBy": FirebaseAuth.instance.currentUser!.email!,
          "to": FirebaseAuth.instance.currentUser!.uid,
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
          "messages": {
            "role": "system",
            "content": prompt,
            "hidden": true,
            "date": DateTime.now().toIso8601String(),
          }
        };

        final response = await apiService.saveDataset(data);

        response.fold((fail) {
          globalKey.currentContext!.pop();
          return AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title:
                  "Ooppss... terjadi kesalahan diserver. silahkan coba lagi");
        }, (r) {
          // emit(state.copyWith(isLoadingProses: false));
          add(TrainGetDataSetEvent());
          add(TrainClearAllFieldEvent());
          return AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: "Data berhasil ditambahkan");
        });
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
    tcSheetLink.clear();
    emit(state.copyWith(
        targetRole: "",
        listId: [],
        promptContent: "",
        urlFile: "",
        isAdd: false));
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, String sheetId) async {
    try {
      return await spreadsheet.addWorksheet(sheetId);
    } catch (e) {
      return spreadsheet.worksheetById(int.parse(sheetId))!;
    }
  }

  FutureOr<void> _onTrainFromSheet(
      TrainFromSheetEvent event, Emitter<TrainState> emit) async {
    AppDialog.dialogLoading(
      context: globalKey.currentContext!,
    );
    final gsheet = GSheets(credentialSheet);
    if (!tcSheetLink.text.contains("https://docs.google.com/spreadsheets/d/")) {
      AppDialog.dialogNoAction(
          context: globalKey.currentContext!,
          title: "Masukkan link sheet yang sesuai yahh");
    } else {
      final spreadSheetId = tcSheetLink.text
          .split("/edit#gid=")[0]
          .replaceAll("https://docs.google.com/spreadsheets/d/", "");
      final sheetId = tcSheetLink.text.split("edit#gid=")[1];

      final spredsheet = await gsheet.spreadsheet(spreadSheetId.trim());
      final worksheet = await _getWorkSheet(spredsheet, sheetId.trim());

      final rows = await worksheet.values.map.allRows() ?? [];
      // List<Map<String, dynamic>> headers = rows[0];

      var uuid = const Uuid().v4();

      final headers = {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      };
      final prompt =
          "konteks: ${tcTitle.text}. respons: ${rows.toString().replaceAll("[", "").replaceAll("]", "").replaceAll("{", "").replaceAll("}", "")}";
      final resToken =
          await apiService.checkTokenPrompt(headers, prompt.trim());
      resToken.fold((l) => globalKey.currentContext!.pop(), (token) async {
        final data = {
          "id": uuid,
          "token": token,
          "title": tcTitle.text,
          "type": "sheet",
          "addedBy": FirebaseAuth.instance.currentUser!.email!,
          "to": "all",
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
          "messages": {
            "role": "system",
            "content": prompt,
            "hidden": true,
            "date": DateTime.now().toIso8601String(),
          }
        };

        final response = await apiService.saveDataset(data);
        response.fold((fail) {
          globalKey.currentContext!.pop();
          return AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title:
                  "Ooppss... terjadi kesalahan diserver. silahkan coba lagi");
        }, (r) {
          add(TrainGetDataSetEvent());
          add(TrainClearAllFieldEvent());
          globalKey.currentContext!.pop();
          return AppDialog.dialogNoAction(
              context: globalKey.currentContext!,
              title: "Data berhasil ditambahkan");
        });
      });
    }
  }

  FutureOr<void> _onTapSource(
      TrainOnTapSourceEvent event, Emitter<TrainState> emit) {
    emit(state.copyWith(source: event.source));
  }

  FutureOr<void> _onAdd(TrainOnAddEvent event, Emitter<TrainState> emit) {
    emit(state.copyWith(isAdd: event.isAdd));
  }

  FutureOr<void> _onTranUnggahData(
      TrainOnUnggahDataEvent event, Emitter<TrainState> emit) {
    if (state.source == "file") {
      add(TrainSaveFileDataEvent());
    }

    if (state.source == "text") {
      add(TrainSaveTextDataEvent());
    }

    if (state.source == "sheet") {
      add(TrainFromSheetEvent());
    }
  }

  FutureOr<void> _onCheckToken(
      TrainOnCheckTokenGPTEvent event, Emitter<TrainState> emit) async {
    final headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };
    final response = await apiService.checkTokenPrompt(headers, event.prompt);
  }
}
