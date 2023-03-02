import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:momentum/momentum.dart';
import 'package:weather_plus/app_colors.dart';
import 'package:weather_plus/src/app/components/favorite/index.dart';
import 'package:weather_plus/src/app/data/services/client_db.dart';
import 'package:weather_plus/src/ui/widgets/card_location.dart';
import 'package:weather_plus/src/ui/widgets/icon_circle.dart';

class FavoriteCityPage extends StatefulWidget {
  const FavoriteCityPage({Key? key}) : super(key: key);

  @override
  State<FavoriteCityPage> createState() => _FavoriteCityPageState();
}

class _FavoriteCityPageState extends MomentumState<FavoriteCityPage> {
  FavoriteController? _favoriteController;

  late ScrollController _scrollViewController;

  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initMomentumState() {
    _favoriteController ??= Momentum.controller<FavoriteController>(context);
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
    super.initMomentumState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light2Background,
      body: Column(
        children: [
          AnimatedContainer(
            height: _showAppbar ? 100.h : 0.0,
            duration: const Duration(milliseconds: 300),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: 100.h,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              leading: Padding(
                padding: REdgeInsets.only(left: 10.0),
                child: IconCircle(
                  icon: IconlyLight.arrow_left_2,
                  iconSize: 20.sp,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                'Tus favoritos ❤',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: MomentumBuilder(
                controllers: const [FavoriteController],
                builder: (context, snapshot) {
                  return FutureBuilder(
                    future: _favoriteController?.weatherService.getFavorites(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const SizedBox();
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SizedBox();
                      } else {
                        return ListView.builder(
                          controller: _scrollViewController,
                          padding: REdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return CardLocation(
                              isLoading: false,
                              locationEntity: snapshot.data?[index],
                              isLiked: true,
                              like: (bool isLiked) async {
                                ElegantNotification.info(
                                  notificationPosition: NotificationPosition.topCenter,
                                  height: 60.h,
                                  animation: AnimationType.fromTop,
                                  description: const Text(
                                    "Se elimino correctamentte",
                                  ),
                                ).show(context);
                                await ClientDB.deleteAtData(index: index);
                                _favoriteController?.model.update();
                                return !isLiked;
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
