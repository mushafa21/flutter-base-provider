import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/model/game_model.dart';
import 'package:flutter_base_project/ui/detail_game/widget/detail_game_sheet.dart';
import 'package:flutter_base_project/utils/helper.dart';
import 'package:flutter_base_project/utils/picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../firebase/firebase_send.dart';
import '../../repository/games_repo.dart';
import '../../utils/custom_dialog.dart';
import '../../utils/log.dart';

class DetailGameProvider extends ChangeNotifier {
  final GameRepo _repo = GameRepo();
  CustomDialog? dialog;
  bool isLoading = false;
  GameModel? dataGame;
  LatLng? currentLocation;
  String? locationName;
  DateTime? date;
  File? imageFile;

  DetailGameProvider(BuildContext context, int id){
    dialog = CustomDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      detailGame(id);
      getCurrentLocation();


    });
  }

  /** Function */

  getCurrentLocation() async{
    currentLocation = await Picker().getCurrentLocation();
    locationName = await Helper().getLocationName(currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0);
    notifyListeners();
  }

  locationPicker(BuildContext context) async{
    final data = await Picker().locationPicker(context, currentLocation ?? LatLng(0, 0));
    if(data != null){
      currentLocation = data;
      locationName = await Helper().getLocationName(currentLocation?.latitude ?? 0, currentLocation?.longitude ?? 0);
    }
    notifyListeners();
  }


  imagePicker(BuildContext context) async{
    Picker().showImageChoices(context: context, callback: (file){
      if(file != null){
        imageFile = file;
        notifyListeners();
      }
    });
  }

  datePicker(BuildContext context) async{
    final data = await Picker().selectDate(context, date ?? DateTime.now());
    if(data != null){
      date = data;
    }
    notifyListeners();
  }
  showSheetMessage(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        context: context, builder: (context){
      return DetailGameSheet(title: "Ini Title", message: "Ini Pesan");
    });
  }

  showDialogSuccess(){
    dialog?.success(message: "Ini Pesan panjaaaaaaaang banget gaisssss coba dibuat sepanjang panjangn nya nyaaaaaaaa",title: "Ini Judul nya",onTap: (){
      Fluttertoast.showToast(msg: "Success");
    });
  }

  showDialogError(){
    dialog?.error(message: "Ini Pesan panjaaaaaaaang banget gaisssss coba dibuat sepanjang panjangn nya nyaaaaaaaa",onTap: (){
      Fluttertoast.showToast(msg: "Error");
    });
  }

  showDialogChoice(){
    dialog?.choice(message: "Ini Pesan panjaaaaaaaang banget gaisssss coba dibuat sepanjang panjangn nya nyaaaaaaaa",onTap: (){
      Fluttertoast.showToast(msg: "Success");
    },onTapCancel: (){
      Fluttertoast.showToast(msg: "Cancel");
    });
  }

  showDialogWarning(){
    dialog?.warning(message: "Ini Pesan panjaaaaaaaang banget gaisssss coba dibuat sepanjang panjangn nya nyaaaaaaaa",onTap: (){
      Fluttertoast.showToast(msg: "Success");
    },onTapCancel: (){
      Fluttertoast.showToast(msg: "Cancel");
    });
  }

  /** API CALL */
  detailGame(int id) async {
    isLoading = false;
    dialog?.showLoading();
    try {
      final response = await _repo.detailGame(id);
      dataGame = response;
      isLoading = false;
      dialog?.dismiss();

    } catch (e) {
      isLoading = false;
      dialog?.dismiss();
      if(e.runtimeType != String){
        dialog?.error(message: "Terjadi Kesalahan, Silahkan coba beberapa saat lagi");
        LogMessage().log(lokasi: "DetailGame", message:"Terjadi Kesalahan, Silahkan coba beberapa saat lagi");
        FirebaseSend().send(lokasi: runtimeType.toString(), message: e.toString());
      } else{
        dialog?.error(message: e.toString());
      }
    }

    notifyListeners();

  }


}
