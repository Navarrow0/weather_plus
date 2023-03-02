
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconCircle extends StatelessWidget {
  const IconCircle(
      {Key? key, required this.icon, this.onPressed, required this.iconSize})
      : super(key: key);

  final IconData icon;
  final double iconSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 40.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
          shape: const CircleBorder(),
        ),
        child: Icon(
          icon,
          size: iconSize,
        ),
      ),
    );
  }
}
