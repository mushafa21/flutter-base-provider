
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/custom_colors.dart';
import '../styles/custom_text_styles.dart';

class ButtonPrimary extends StatelessWidget {
  final Function() click;
  final String teks;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final bool active;
  final TextStyle? textStyle;
  final double? verticalPadding;
  final double? horizontalPadding;


  const ButtonPrimary({Key? key,required this.click, required this.teks,this.width, this.height,this.color,this.textColor, this.active = true, this.textStyle, this.verticalPadding, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: click,style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: verticalPadding ?? 10.h,horizontal: horizontalPadding ??  30.w)),
      minimumSize: MaterialStateProperty.all(Size(width ?? double.infinity, height ?? 55.h)),
      backgroundColor:
      MaterialStateProperty.all(active ? color ?? CustomColors.primary500 : CustomColors.gray100),
    ), child : Text(teks, style: textStyle ?? CustomTextStyles.semiBold12.copyWith(color: textColor ?? (active ? CustomColors.white:CustomColors.gray500)),),);
  }
}