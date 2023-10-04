

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/custom_text_styles.dart';


class ViewKosong extends StatelessWidget {
  final String title;
  final String message;
  final String asset;
  const ViewKosong({Key? key, this.title = "Tidak Menemukan Data", this.message = "Kami tidak menemukan data yang anda cari", this.asset = "assets/images/img_empty.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(asset,width: 120.w,height: 120.w,),
          SizedBox(height: 10.h,),
          Text(title,style: CustomTextStyles.bold14,),
          SizedBox(height: 5.h,),
          Text(message,style: CustomTextStyles.reguler12,)
        ],
      ),
    );
  }
}
