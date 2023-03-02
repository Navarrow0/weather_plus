import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:weather_plus/app_colors.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';
import 'package:weather_plus/src/ui/widgets/skeleton.dart';

import 'icon_circle.dart';

class CardLocation extends StatelessWidget {
  const CardLocation({
    Key? key,
    this.locationEntity,
    required this.isLoading,
    this.onTap,
    this.like, this.isLiked = false, this.icon = IconlyLight.location,
  }) : super(key: key);

  final bool isLoading;
  final LocationEntity? locationEntity;
  final void Function()? onTap;
  final Future<bool?> Function(bool)? like;
  final bool? isLiked;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          height: 70.h,
          padding: REdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff7090B0).withAlpha(40),
                    offset: const Offset(0, 16),
                    blurRadius: 40)
              ],
              borderRadius: BorderRadius.circular(15)),
          child: isLoading
              ? const _LoadingData()
              : _CountryData(
            name: locationEntity?.name ?? '',
            country: locationEntity?.country ?? '',
            state: locationEntity?.state ?? '',
            like: like,
              isLiked: isLiked, icon: icon,
          ),
        ),
      ),
    );
  }
}

class _LoadingData extends StatelessWidget {
  const _LoadingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton(
          height: 45.h,
          width: 45.w,
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(
              height: 8.h,
              width: 75.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            Skeleton(
              height: 8.h,
              width: 150.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            Skeleton(
              height: 8.h,
              width: 150.w,
            ),
          ],
        )
      ],
    );
  }
}

class _CountryData extends StatelessWidget {
  const _CountryData(
      {Key? key,
        required this.name,
        required this.country,
        this.state,
        this.like, this.isLiked, required this.icon})
      : super(key: key);
  final String name;
  final String country;
  final String? state;
  final Future<bool?> Function(bool)? like;
  final bool? isLiked;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconCircle(
          icon: icon,
          iconSize: 30.sp,
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: $name'),
            Text('País: $country'),
            Text('Estado: $state')
          ],
        ),
        const Spacer(),
        Padding(
          padding: REdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              LikeButton(
                size: 20.sp,
                isLiked: isLiked,
                onTap: like,
              ),
            ],
          ),
        )
      ],
    );
  }
}
