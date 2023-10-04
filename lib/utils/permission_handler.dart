


import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  Future<bool> askPermission({bool location = false, bool media = false,bool notifikasi = false, bool image = false}) async{
    bool granted = true;
    if(location){
      var status = await Permission.location.request();
      if (status.isDenied) {
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses lokasi anda untuk melanjutkan");
      }
      if (status.isRestricted) {
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses lokasi anda untuk melanjutkan");
      }

      if (status.isPermanentlyDenied){
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses lokasi anda untuk melanjutkan");
      }
    }

    if(image){
      if(Platform.isAndroid){
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var sdkInt = androidInfo.version.sdkInt;
        if(sdkInt >= 33){
          var statusPhoto = await Permission.photos.request();

          if (statusPhoto.isDenied  ) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


          }

          if (statusPhoto.isPermanentlyDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
          }
        } else{
          var statusStorage = await Permission.storage.request();
          if (statusStorage.isDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


          }

          if (statusStorage.isPermanentlyDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
          }

        }




      } else{
        var statusPhoto = await Permission.photos.request();
        var statusCamera = await Permission.camera.request();

        if (statusPhoto.isDenied  || statusCamera.isDenied  ) {
          granted = false;
          Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


        }

        if (statusPhoto.isPermanentlyDenied  || statusCamera.isPermanentlyDenied) {
          granted = false;
          Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
        }
      }
    }



    if(media){
      if(Platform.isAndroid){
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var sdkInt = androidInfo.version.sdkInt;
        if(sdkInt >= 33){
          var statusPhoto = await Permission.photos.request();
          var statusVideo = await Permission.videos.request();
          var statusAudio = await Permission.audio.request();

          if (statusPhoto.isDenied || statusAudio.isDenied || statusVideo.isDenied  ) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


          }

          if (statusPhoto.isPermanentlyDenied || statusAudio.isPermanentlyDenied || statusVideo.isPermanentlyDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
          }
        } else{
          var statusStorage = await Permission.storage.request();
          if (statusStorage.isDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


          }

          if (statusStorage.isPermanentlyDenied) {
            granted = false;
            Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
          }

        }




      } else{
        var statusPhoto = await Permission.photos.request();
        var statusCamera = await Permission.camera.request();

        if (statusPhoto.isDenied  || statusCamera.isDenied  ) {
          granted = false;
          Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");


        }

        if (statusPhoto.isPermanentlyDenied  || statusCamera.isPermanentlyDenied) {
          granted = false;
          Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk mengakses berkas anda untuk melanjutkan");
        }
      }

    }

    if(notifikasi){
      var status = await Permission.notification.request();
      if (status.isDenied) {
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk memberikan notifikasi anda untuk melanjutkan");
      }
      if (status.isRestricted) {
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk memberikan notifikasi anda untuk melanjutkan");
      }
      if (status.isPermanentlyDenied) {
        granted = false;
        Fluttertoast.showToast(msg: "Silahkan berikan izin aplikasi untuk memberikan notifikasi anda untuk melanjutkan");
      }
    }
    return granted;

  }
}