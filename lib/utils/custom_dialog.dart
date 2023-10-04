

import 'package:flutter/material.dart';
import 'package:flutter_base_project/styles/custom_colors.dart';
import 'package:flutter_base_project/styles/custom_text_styles.dart';
import 'package:flutter_base_project/widget/button_primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CustomDialog{
  final BuildContext context;
  bool isShowing = false;

  CustomDialog(this.context);

  dismiss(){
    print("showing = ${isShowing}");
    if(isShowing){
      Navigator.pop(context);
      isShowing = false;
    }
  }


  showLoading({bool dismissible = false}) {
    isShowing = true;
    print("showing = ${isShowing}");
    showDialog(
      barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return LoadingDialog();
        }).then((value) {
      isShowing = false;
    });
  }




  choice({required String message, bool exit = false, Function()? onExit,String? confirmButtonText,String? cancelButtonText, bool dismissible = true, Function()? onTap,Function()? onTapCancel,String? title,String? asset}) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return ChoiceDialog(message: message,onTap: onTap,confirmButtonText: confirmButtonText,cancelButtonText: cancelButtonText,onTapCancel: onTapCancel,title: title,asset: asset,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }

  success({required String message,String? title, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap,String? asset} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return SuccessDialog(message: message,onTap: onTap,buttonText: confirmButtonText,asset: asset,title: title,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }

  message({required String message,String? title, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap,String? asset} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(message: message,onTap: onTap,buttonText: confirmButtonText,asset: asset,title: title,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }


  error({required String message,String? title, bool exit = false, Function()? onExit,String? confirmButtonText, bool dismissible = true, Function()? onTap,String? asset} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(message: message,onTap: onTap,buttonText: confirmButtonText,asset: asset,title: title,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }

  warning({required String message, bool exit = false, Function()? onExit,String? confirmButtonText,String? cancelButtonText, bool dismissible = true, Function()? onTap,Function()? onTapCancel,String? title,String? asset} ) async {
    isShowing = true;
    await showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(message: message,onTap: onTap,confirmButtonText: confirmButtonText,cancelButtonText: cancelButtonText,onTapCancel: onTapCancel,title: title,asset: asset,);
        }).then((value) {
      isShowing = false;
    });
    if (exit) {
      Navigator.pop(context);
    }
    if(onExit != null){
      onExit();
    }
  }
}


class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        height: 150.w,
        width: 150.w,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Center(
            child: Lottie.asset('assets/animations/loading_lottie.json',width: 150.w,height: 150.w,fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );
  }
}



class SuccessDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? asset;
  final String? buttonText;
  final Function()? onTap;
  const SuccessDialog({super.key, required this.message, this.onTap,  this.title,  this.asset,  this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(asset ?? "assets/images/img_dialog_success.png",height: 200.h,),
              SizedBox(height: 15.h,),
              Text(title ?? "Success",style: CustomTextStyles.bold18,textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),
              Text(message,style: CustomTextStyles.reguler12,textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              ButtonPrimary(click: (){
                Navigator.pop(context);
                if(onTap != null){
                  onTap!();
                }

              }, teks: buttonText ?? "Ok",height: 0,width: 0,)
            ],
          ),
        ),
      ),
    );
  }
}

class MessageDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? asset;
  final String? buttonText;
  final Function()? onTap;
  const MessageDialog({super.key, required this.message, this.onTap,  this.title,  this.asset,  this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(asset ?? "assets/images/img_dialog_general.png",height: 200.h,),
              SizedBox(height: 15.h,),
              Text(title ?? "Success",style: CustomTextStyles.bold18,textAlign: TextAlign.center,),
              SizedBox(height: 10.h,),
              Text(message,style: CustomTextStyles.reguler12,textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              ButtonPrimary(click: (){
                Navigator.pop(context);
                if(onTap != null){
                  onTap!();
                }

              }, teks: buttonText ?? "Ok",height: 0,width: 0,)
            ],
          ),
        ),
      ),
    );
  }
}



class ErrorDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? asset;
  final String? buttonText;
  final Function()? onTap;
  const ErrorDialog({super.key, required this.message, this.onTap,  this.title,  this.asset,  this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.circleInfo,size: 16.w,),
                  SizedBox(width: 10.w,),
                  Text(title ?? "Oops! Something went wrong",style: CustomTextStyles.bold14.copyWith(color: CustomColors.error500),textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(height: 15.h,),
              Image.asset(asset ?? "assets/images/img_dialog_error.png",height: 200.h,),
              SizedBox(height: 10.h,),
              Text(message,style: CustomTextStyles.reguler12,textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              Align(
                alignment: Alignment.centerRight,
                child: ButtonPrimary(click: (){
                  Navigator.pop(context);
                  if(onTap != null){
                    onTap!();
                  }

                }, teks: buttonText ?? "Close",height: 0,width: 0,color: CustomColors.error100,textColor: CustomColors.error500,),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WarningDialog extends StatelessWidget {
  final String? title;
  final String? asset;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final String message;
  final Function()? onTap;
  final Function()? onTapCancel;
  const WarningDialog({super.key, required this.message, this.onTap,  this.title,  this.asset, this.confirmButtonText, this.cancelButtonText, this.onTapCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.circleInfo,size: 16.w,),
                  SizedBox(width: 10.w,),
                  Text(title ?? "Oops! Something went wrong",style: CustomTextStyles.bold14.copyWith(color: CustomColors.error500),textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(height: 15.h,),
              Image.asset(asset ?? "assets/images/img_dialog_warning.png",height: 200.h,),
              SizedBox(height: 10.h,),
              Text(message,style: CustomTextStyles.reguler12,textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      if(onTapCancel != null){
                        onTapCancel!();
                      }

                    } ,
                      child: Text(cancelButtonText ?? "Cancel",style: CustomTextStyles.reguler12.copyWith(color: CustomColors.error500),)),
                  SizedBox(width: 30.w,),
                  ButtonPrimary(click: (){
                    Navigator.pop(context);
                    if(onTap != null){
                      onTap!();
                    }

                  }, teks: confirmButtonText ?? "Ok",height: 0,width: 0,color: CustomColors.error100,textColor: CustomColors.error500,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class ChoiceDialog extends StatelessWidget {
  final String? title;
  final String? asset;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final String message;
  final Function()? onTap;
  final Function()? onTapCancel;

  const ChoiceDialog({super.key, required this.message, this.onTap, this.confirmButtonText, this.cancelButtonText, this.title, this.asset, this.onTapCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20.r)), //this right here
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title ?? "Confirmation",style: CustomTextStyles.bold18,textAlign: TextAlign.center,),
              SizedBox(height: 15.h,),
              Image.asset(asset ?? "assets/images/img_dialog_choice.png",height: 200.h,),
              SizedBox(height: 10.h,),
              Text(message,style: CustomTextStyles.reguler12,textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonPrimary(click: (){
                    Navigator.pop(context);
                    if(onTapCancel != null){
                      onTapCancel!();
                    }

                  }, teks: cancelButtonText ?? "Cancel",height: 0,width: 0,color: CustomColors.primary100,textColor: CustomColors.gray500,),
                  SizedBox(width: 20.w,),
                  ButtonPrimary(click: (){
                    Navigator.pop(context);
                    if(onTap != null){
                      onTap!();
                    }

                  }, teks: confirmButtonText ?? "Ok",height: 0,width: 0,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

