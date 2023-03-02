
import 'package:momentum/momentum.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'location.controller.dart';

class LocationModel extends MomentumModel<LocationController> {
  const LocationModel(LocationController controller, {this.timeParametersEntity})
      : super(controller);



  final TimeParametersEntity? timeParametersEntity;

  @override
  void update({TimeParametersEntity? timeParametersEntity}) {
    LocationModel(
      controller,
      timeParametersEntity: timeParametersEntity ?? this.timeParametersEntity,
    ).updateMomentum();
  }
}
