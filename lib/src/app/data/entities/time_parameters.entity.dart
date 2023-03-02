
import 'package:json_annotation/json_annotation.dart';
part 'time_parameters.entity.g.dart';

@JsonSerializable()
class TimeParametersEntity {
  double? lat;
  double? lon;
  String? units;
  String? lang;
  String? APPID;
  String? q;
  int? limit;

  TimeParametersEntity({
    this.lat,
    this.lon,
    this.units = 'metric',
    this.lang = 'es',
    this.APPID = '3782ff776f8ef95f635a985442def16e',
    this.q,
    this.limit = 10
  });

  factory TimeParametersEntity.fromJson(Map<String, dynamic> json) => _$TimeParametersEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TimeParametersEntityToJson(this);
}