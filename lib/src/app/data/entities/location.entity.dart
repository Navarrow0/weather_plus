import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.entity.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class LocationEntity extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double lat;
  @HiveField(2)
  final double lon;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String? state;

  LocationEntity({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);
}
