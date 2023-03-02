// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_parameters.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeParametersEntity _$TimeParametersEntityFromJson(
        Map<String, dynamic> json) =>
    TimeParametersEntity(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      units: json['units'] as String? ?? 'metric',
      lang: json['lang'] as String? ?? 'es',
      APPID: json['APPID'] as String? ?? '3782ff776f8ef95f635a985442def16e',
      q: json['q'] as String?,
      limit: json['limit'] as int? ?? 10,
    );

Map<String, dynamic> _$TimeParametersEntityToJson(
        TimeParametersEntity instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'units': instance.units,
      'lang': instance.lang,
      'APPID': instance.APPID,
      'q': instance.q,
      'limit': instance.limit,
    };
