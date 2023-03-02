import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:weather_plus/app_colors.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({Key? key, this.onTapSelectCity, required this.locationName, this.onSelected}) : super(key: key);

  final void Function()? onTapSelectCity;
  final String locationName;
  final void Function(int)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SelectCity(onTap: onTapSelectCity, locationName: locationName,),

          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Icon(IconlyLight.info_square),
                    SizedBox(
                      width: 6.w,
                    ),
                    const Text("Celsius"),
                  ],
                )
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(IconlyLight.info_square),
                    SizedBox(
                      width: 6.w,
                    ),
                    const Text("Fahrenheit"),
                  ],
                )
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            offset: const Offset(-30,35),
            elevation: 0,
            onSelected: onSelected,
            child: const _IconWithContainer(icon: IconlyLight.more_circle,)

          ),
        ],
      ),
    );
  }
}

class _SelectCity extends StatelessWidget {
  const _SelectCity({Key? key, this.onTap, required this.locationName}) : super(key: key);

  final void Function()? onTap;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Row(
          children: [
            const _IconWithContainer(icon: IconlyLight.location,),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationName,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBackground),
                ),
                Text(
                  'Escoge tú ciudad',
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBackground),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


class _IconWithContainer extends StatelessWidget {
  const _IconWithContainer({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: AppColors.opacity25, shape: BoxShape.circle),
      child: Icon(
        icon,
        color: AppColors.lightBackground,
        size: 25.sp,
      ),
    );
  }
}
