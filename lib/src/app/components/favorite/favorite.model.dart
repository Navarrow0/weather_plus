
import 'package:momentum/momentum.dart';
import 'favorite.controller.dart';

class FavoriteModel extends MomentumModel<FavoriteController> {
  const FavoriteModel(FavoriteController controller,)
      : super(controller);
  @override
  void update() {
    FavoriteModel(
      controller,
    ).updateMomentum();
  }
}
