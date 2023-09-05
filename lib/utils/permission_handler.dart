


import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  Future<bool> askPermission({bool location = false, bool media = false,bool notifikasi = false}) async{
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



    if(media){
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