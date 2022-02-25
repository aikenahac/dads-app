import 'package:dads_app/models/activity/activity_li_attributes.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_list_item.model.g.dart';

@JsonSerializable()
class ActivityListItem {
  final int id;
  final ActivityLiAttributes attributes;

  ActivityListItem(
    this.id,
    this.attributes,
  );

  factory ActivityListItem.fromJson(Map<String, dynamic> json) => _$ActivityListItemFromJson(json);
}
