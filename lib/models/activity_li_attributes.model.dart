import 'package:json_annotation/json_annotation.dart';

part 'activity_li_attributes.model.g.dart';

@JsonSerializable()
class ActivityLiAttributes {
  final String short;
  final bool done;

  ActivityLiAttributes(
    this.short,
    this.done,
  );

  factory ActivityLiAttributes.fromJson(Map<String, dynamic> json) => _$ActivityLiAttributesFromJson(json);
}
