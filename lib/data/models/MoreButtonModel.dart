import 'package:freezed_annotation/freezed_annotation.dart';

part 'MoreButtonModel.freezed.dart';

part 'MoreButtonModel.g.dart';

@freezed
abstract class MoreButtonModel with _$MoreButtonModel {
  factory MoreButtonModel(
      {required String name,
      required String link,
      required int position}) = _MoreButtonModel;

  factory MoreButtonModel.fromJson(Map<String, dynamic> json) =>
      _$MoreButtonModelFromJson(json);
}
