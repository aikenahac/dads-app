// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list_item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityListItem _$ActivityListItemFromJson(Map<String, dynamic> json) =>
    ActivityListItem(
      json['id'] as int,
      ActivityLiAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityListItemToJson(ActivityListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes,
    };
