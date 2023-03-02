
import 'package:momentum/momentum.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'home.controller.dart';

class HomeModel extends MomentumModel<HomeController> {
  const HomeModel(HomeController controller, {this.timeParametersEntity, this.isComingFromList = false})
      : super(controller);

  final TimeParametersEntity? timeParametersEntity;
  final bool isComingFromList;

  @override
  void update({TimeParametersEntity? timeParametersEntity, bool? isComingFromList}) {
    HomeModel(
      controller,
      timeParametersEntity: timeParametersEntity ?? this.timeParametersEntity,
      isComingFromList: isComingFromList ?? this.isComingFromList
    ).updateMomentum();
  }
}
