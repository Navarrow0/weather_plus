import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:momentum/momentum.dart';
import 'package:weather_plus/app_colors.dart';
import 'package:weather_plus/src/app/components/auth/index.dart';
import 'package:weather_plus/src/app/components/location/index.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';
import 'package:weather_plus/src/app/data/entities/time_parameters.entity.dart';
import 'package:weather_plus/src/app/data/services/client_db.dart';
import 'package:weather_plus/src/ui/pages/favorites/favorite_city_page.dart';
import 'package:weather_plus/src/ui/widgets/card_location.dart';
import 'package:weather_plus/src/ui/widgets/icon_circle.dart';
import 'package:weather_plus/src/ui/widgets/skeleton.dart';
import 'package:weather_plus/src/utils/debouncer.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends MomentumState<LocationsPage> {
  HomeController? _homeController;
  LocationController? _locationController;

  final Debouncer _debounce = Debouncer(milliseconds: 400);
  late ScrollController _scrollViewController;

  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initMomentumState() {
    _homeController ??= Momentum.controller<HomeController>(context);
    _locationController ??= Momentum.controller<LocationController>(context);
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
            height: _showAppbar ? 200.h : 0.0,
            duration: const Duration(milliseconds: 300),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: 200.h,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconCircle(
                        icon: IconlyLight.arrow_left_2,
                        iconSize: 24.sp,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconCircle(
                        icon: IconlyLight.heart,
                        iconSize: 24.sp,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FavoriteCityPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Hola 👋',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Encontremos la ciudad de tus sueños',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      _locationController?.model.update(
                          timeParametersEntity: TimeParametersEntity(q: value));
                      _debounce.run(() {
                        _locationController?.updateFuture();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(IconlyLight.search),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                      hintText: 'Escribe tu ciudad...',
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: MomentumBuilder(
                controllers: const [LocationController],
                builder: (context, snapshot) {
                  return FutureBuilder(
                    future: _locationController?.searchLocation,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const SizedBox();
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ListView.builder(
                          controller: _scrollViewController,
                          padding: REdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          itemCount: 7,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return const CardLocation(
                              isLoading: true,
                            );
                          },
                        );
                      } else {
                        return snapshot.data!.when((success) {
                          return ListView.builder(
                            controller: _scrollViewController,
                            padding: REdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            itemCount: success.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              return CardLocation(
                                isLoading: false,
                                locationEntity: success[index],
                                like: (bool isLiked) async {
                                  if (!isLiked) {
                                    ElegantNotification.success(
                                      notificationPosition: NotificationPosition.topCenter,
                                      height: 60.h,
                                      animation: AnimationType.fromTop,
                                      description: const Text(
                                        "Se Agregó correctamentte",
                                      ),
                                    ).show(context);
                                    await ClientDB.addData(
                                      value: success[index],
                                    );
                                  } else {
                                    ElegantNotification.info(
                                      notificationPosition: NotificationPosition.topCenter,
                                      height: 60.h,
                                      animation: AnimationType.fromTop,
                                      description: const Text(
                                        "Se elimino correctamentte",
                                      ),
                                    ).show(context);
                                    await ClientDB.deleteAtData(index: index);
                                  }
                                  return !isLiked;
                                },
                                onTap: () {
                                  _homeController?.model.update(timeParametersEntity: TimeParametersEntity(lat: success[index].lat, lon: success[index].lon));
                                  _homeController?.updateWeather();
                                  ElegantNotification.success(
                                      notificationPosition:
                                          NotificationPosition.topCenter,
                                      height: 60.h,
                                      animation: AnimationType.fromTop,
                                      description: const Text(
                                        "Se selecciono correctamente",
                                      )).show(context);
                                },
                              );
                            },
                          );
                        }, (error) {
                          return Padding(
                            padding: REdgeInsets.only(top: 22.0),
                            child: Text(error),
                          );
                        });
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

