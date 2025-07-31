// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MoreButtonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoreButtonModel _$MoreButtonModelFromJson(Map<String, dynamic> json) =>
    _MoreButtonModel(
      name: json['name'] as String,
      link: json['link'] as String,
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$MoreButtonModelToJson(_MoreButtonModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'position': instance.position,
    };
