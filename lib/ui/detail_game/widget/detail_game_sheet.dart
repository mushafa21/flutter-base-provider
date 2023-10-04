import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/custom_colors.dart';
import '../../../styles/custom_text_styles.dart';
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
          color: CustomColors.white,
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
                      color: CustomColors.gray100,
                      borderRadius: BorderRadius.circular(3.w)),
                ),
              ),

              Image.asset(image != null ? image! : "assets/images/img_empty.png",width: double.infinity,),
              SizedBox(height: 15.h,),
              Text(title,style: CustomTextStyles.semiBold18,),
              SizedBox(height: 5.h,),

              Text(message,style: CustomTextStyles.reguler12.copyWith(color: CustomColors.gray400),),
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
