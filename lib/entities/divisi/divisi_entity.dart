import 'package:freezed_annotation/freezed_annotation.dart';

part 'divisi_entity.freezed.dart';
part 'divisi_entity.g.dart';

@freezed
class DivisiEntity with _$DivisiEntity {
  const factory DivisiEntity({
    required String id,
    required String divisi,
    required String divisiId,
  }) = _DivisiEntity;

  factory DivisiEntity.fromJson(Map<String, dynamic> json) =>
      _$DivisiEntityFromJson(json);
}
