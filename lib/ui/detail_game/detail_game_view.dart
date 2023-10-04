import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../styles/custom_text_styles.dart';
import '../../widget/button_primary.dart';
import '../../widget/image_view.dart';
import 'detail_game_provider.dart';

class DetailGamePage extends StatelessWidget {
  final int idGame;

  const DetailGamePage({super.key, required this.idGame});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DetailGameProvider(context, idGame),
      child: Consumer<DetailGameProvider>(
        builder: (context, provider, child) {

          AppBar appBar(){
            return AppBar(
              title: Text("Detail Game",style: CustomTextStyles.semiBold14,),
            );
          }

          Widget viewImage(){
            return ImageView(url: provider.dataGame?.backgroundImage ?? "");
          }
          Widget viewData(){
            return Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                children: [
                  Text(provider.dataGame?.name ?? "",style: CustomTextStyles.semiBold14,),
                  SizedBox(height: 10.h,),
                  Text(provider.dataGame?.released ?? "",style: CustomTextStyles.reguler12,),
                ],
              ),
            );
          }

          Widget buttonLocationPicker(){
            return Column(
              children: [
                Text(provider.locationName ?? "Sedang mencari lokasi....",style: CustomTextStyles.reguler12,),
                ButtonPrimary(click: (){
                  provider.locationPicker(context);
                }, teks: "Pick Location"),
              ],
            );
          }


          Widget buttonDatePicker(){
            return Column(
              children: [
                Text(provider.date != null ? Helper().dateTimeToString(waktu: provider.date!) : "Pilih Tanggal",style: CustomTextStyles.reguler12,),
                ButtonPrimary(click: (){
                  provider.datePicker(context);
                }, teks: "Pick Date"),
              ],
            );
          }


          Widget buttonImagePicker(){
            return Column(
              children: [
                ButtonPrimary(click: (){
                  provider.imagePicker(context);
                }, teks: "Pick Image"),
                provider.imageFile != null ? Image.file(provider.imageFile!) : Container()
              ],

            );
          }


          Widget buttonSheet(){
            return ButtonPrimary(click: (){
              provider.showSheetMessage(context);
            }, teks: "Show Sheet");
          }

          Widget buttonDialogSuccess(){
            return ButtonPrimary(click: (){
              provider.showDialogSuccess();
            }, teks: "Dialog Success");
          }

          Widget buttonDialogError(){
            return ButtonPrimary(click: (){
              provider.showDialogError();
            }, teks: "Dialog Error");
          }

          Widget buttonDialogChoice(){
            return ButtonPrimary(click: (){
              provider.showDialogChoice();
            }, teks: "Dialog Choice");
          }
          Widget buttonDialogWarning(){
            return ButtonPrimary(click: (){
              provider.showDialogWarning();
            }, teks: "Dialog Warning");
          }
          Widget viewMain(){
            return RefreshIndicator(
              onRefresh: () {
                provider.detailGame(idGame);
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      viewImage(),
                      viewData(),
                      buttonLocationPicker(),
                      SizedBox(height: 10.h,),
                      buttonDatePicker(),
                      SizedBox(height: 10.h,),
                      buttonImagePicker(),
                      SizedBox(height: 10.h,),
                      buttonSheet(),
                      SizedBox(height: 10.h,),

                      buttonDialogSuccess(),
                      SizedBox(height: 10.h,),

                      buttonDialogError(),
                      SizedBox(height: 10.h,),

                      buttonDialogChoice(),
                      SizedBox(height: 10.h,),

                      buttonDialogWarning(),

                    ],
                  ),
                ),
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              appBar: appBar(),
              body: viewMain(),
            ),
          );
        },
      ),
    );
  }

}