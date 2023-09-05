import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../style/custom_color.dart';
import '../../../style/custom_text_style.dart';
import '../../../widget/button_primary.dart';



class DetailGameSheet extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final String? image;
  final Function()? callback;

  const DetailGameSheet({Key? key, required this.title,required this.message,this.image,this.callback,this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20.w),
          color: CustomColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.w,
                  margin: EdgeInsets.all(20.h),
                  decoration: BoxDecoration(
                      color: CustomColor.gray100,
                      borderRadius: BorderRadius.circular(3.w)),
                ),
              ),

              Image.asset(image != null ? image! : "asset/images/img_empty.png",width: double.infinity,),
              SizedBox(height: 15.h,),
              Text(title,style: CustomTextStyle.semiBold18,),
              SizedBox(height: 5.h,),

              Text(message,style: CustomTextStyle.reguler12.copyWith(color: CustomColor.gray400),),
              SizedBox(height: 20.h,),
              ButtonPrimary(click: (){
                if(callback != null){
                  callback!();
                } else{
                  Navigator.pop(context);
                }


              }, teks: buttonText ?? "Oke"),




            ],
          ),
        ),
      ),
    );
  }
}
