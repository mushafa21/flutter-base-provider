

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/custom_dialog.dart';
import 'package:flutter_base_project/utils/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../style/custom_color.dart';
import '../style/custom_text_style.dart';
import '../widget/button_primary.dart';
import 'config.dart';
import 'helper.dart';

class Picker{
  /** Media Picker */
  final imagePicker = ImagePicker();
  showMediaChoices({required BuildContext context,required Function(File?,String) callback,bool crop = false}) async {
    if(await PermissionHandler().askPermission(media : true)){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(15.w),
                color: CustomColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: CustomColor.gray400,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Pilih Media",
                      style: CustomTextStyle.bold18,
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        child: ListTile(
                          onTap: () async {
                            Navigator.pop(context);
                            showImageChoices(context: context, callback: (file){
                              callback(file,"IMAGE");
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.image, color: CustomColor.primary500),
                          title: Text("Foto",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          showVideoChoices(context: context, callback: (file){
                            callback(file,"VIDEO");
                          });
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.video, color: CustomColor.primary500),
                          title: Text("Video",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else{
      CustomDialog(context).message(message: "Silahkan Berikan Izin Aplikasi Untuk Mengambil Media",onTap: (){
        showMediaChoices(context: context, callback: callback,crop: crop);
      });
    }


  }


  showVideoChoices({required BuildContext context,required Function(File?) callback,bool crop = false}) async {
    if(await PermissionHandler().askPermission(media : true)){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(15.w),
                color: CustomColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: CustomColor.gray400,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Pilih Pengambilan Video",
                      style: CustomTextStyle.bold18,
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        child: ListTile(
                          onTap: () async {
                            Navigator.pop(context);
                            callback(await pickVideo(context: context,camera: true ));
                          },
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.camera, color: CustomColor.primary500),
                          title: Text("Kamera",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          callback(await pickVideo(context: context,camera: false,));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.solidFolderOpen, color: CustomColor.primary500),
                          title: Text("Galeri",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else{
      CustomDialog(context).message(message: "Silahkan Berikan Izin Aplikasi Untuk Mengambil Gambar",onTap: (){
        showImageChoices(context: context, callback: callback,crop: crop);
      });
    }


  }



  showImageChoices({required BuildContext context,required Function(File?) callback,bool crop = false}) async {
    if(await PermissionHandler().askPermission(media : true)){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(15.w),
                color: CustomColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color: CustomColor.gray400,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Pilih Pengambilan Gambar",
                      style: CustomTextStyle.bold18,
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        child: ListTile(
                          onTap: () async {
                            Navigator.pop(context);
                            callback(await pickImage(context: context,camera: true ));
                          },
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.camera, color: CustomColor.primary500),
                          title: Text("Kamera",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                    Material(
                      color: CustomColor.transparant,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          callback(await pickImage(context: context,camera: false,));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 0,
                          leading: FaIcon(FontAwesomeIcons.solidFolderOpen, color: CustomColor.primary500),
                          title: Text("Galeri",style: CustomTextStyle.semiBold12,),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else{
      CustomDialog(context).message(message: "Silahkan Berikan Izin Aplikasi Untuk Mengambil Gambar",onTap: (){
        showImageChoices(context: context, callback: callback,crop: crop);
      });
    }


  }

  Future<File?> pickVideo({bool camera = false, required BuildContext context}) async {
    final permission = await PermissionHandler().askPermission(media: true);
    if(permission){
      try {
        XFile? pickedFile = await imagePicker.pickVideo(source: camera ? ImageSource.camera : ImageSource.gallery);
        if(pickedFile != null){
          return File(pickedFile.path);
        } else{
          return null;
        }
      } catch (e) {
        return null;


      }
    } else{
      return null;

    }


  }

  Future<File?> pickImage({bool camera = false, required BuildContext context}) async {
    final permission = await PermissionHandler().askPermission(media: true);
    if(permission){
      try {
        XFile? pickedFile = await imagePicker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery,maxHeight: 1200, maxWidth: 1200,);
        if(pickedFile != null){
          return File(pickedFile.path);
        } else{
          return null;
        }
      } catch (e) {
        return null;


      }
    } else{
      return null;
    }

  }
  
  /** Date / Time Picker */
  Future<DateTime?> selectDate(BuildContext context, DateTime dateTime,
      {DateTime? startDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate ?? dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: startDate ?? DateTime(1940),
        lastDate: DateTime(2101));
    return picked;
  }

  Future<DateTime?> selectMonthYear(BuildContext context, DateTime dateTime,DateTime? firstDate, DateTime? lastDate) async {
    return await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: firstDate ?? DateTime(2019),
      lastDate: lastDate ?? DateTime(2023),
    );
  }

  selectYear(BuildContext context, Function(String) callback) async {
    await showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          // Changing default contentPadding to make the content looks better

          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: size.height / 3,
            width: size.width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 20 years starting from now
                // Change it depending on your needs.
                ...List.generate(
                  20,
                      (index) => InkWell(
                    onTap: () {
                      // The action you want to happen when you select the year below,
                      callback((int.parse(Helper().dateTimeToString(waktu: DateTime.now(),format: "yyyy")) - index).toString());
                      // Quitting the dialog through navigator.
                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Chip(
                        label: Container(
                          padding: EdgeInsets.all(5.w),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (int.parse(Helper().dateTimeToString(waktu: DateTime.now(),format: "yyyy")) - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<TimeOfDay?> selectTime(BuildContext context, TimeOfDay timeOfDay) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: timeOfDay,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    return picked;
  }

  Future<DateTime?> selectDateTime(BuildContext context,DateTime dateTime) async {
    final date = await selectDate(context, dateTime);
    if(date == null){
      return null;
    }

    final timeOfDay = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    final time = await selectTime(context, timeOfDay);
    if(time == null){
      return null;
    }

    return DateTime(date.year,date.month,date.day,time.hour,time.minute);

  }

  /** Location Picker */
  Future<LatLng?> getCurrentLocation() async{
    if(await PermissionHandler().askPermission(location: true)){
      Location location = Location();
      final data = await location.getLocation();
      return LatLng(data.latitude ?? 0, data.longitude ?? 0);
    } else{
      return null;
    }
  }
  Future<LatLng?> locationPicker(BuildContext context,LatLng initialLocation) async {
    final location = await Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationPickerScreen(startLocation: initialLocation,)));
    if(location != null){
      return location;
    } else{
      return null;

    }
  }
}

class LocationPickerScreen extends StatefulWidget {
  final LatLng? startLocation;

  LocationPickerScreen({this.startLocation});

  @override
  _LocationPickerScreenState createState() {
    return _LocationPickerScreenState();
  }
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  String googleApikey = Config.googleApi;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "";


  void initalLocationName() async{
    location = await Helper().getLocationName(widget.startLocation?.latitude ?? 0, widget.startLocation?.longitude ?? 0);
    setState(() {
    });
  }


  @override
  void initState() {
    super.initState();
    initalLocationName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: Text(
                "Pilih Lokasi",
                style: CustomTextStyle.semiBold18,
              ),
              automaticallyImplyLeading: true),
          body: Stack(children: [
            GoogleMap(
              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: widget.startLocation!, //initial position
                zoom: 20.0, //initial zoom level
              ),
              mapType: MapType.normal,
              //map type
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
              },
              onCameraIdle: () async {
                //when map drag stops
                if (cameraPosition != null) {
                  String namaLokasi =
                  await Helper().getLocationName(cameraPosition!.target.latitude,cameraPosition!.target.longitude);
                  setState(() {
                    //get place name from lat and lang
                    location = namaLokasi;
                  });
                }
              },
            ),
            Center(
              //picker image on google map
              child: FaIcon(
                FontAwesomeIcons.locationDot,
                color: CustomColor.primary500,
                size: 50.w,
              ),
            ),
            Positioned(
              //widget to display location name
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w,bottom: 10.h),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                              borderRadius: BorderRadius.circular(10.r),
                              color: CustomColor.primary500,
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.locationCrosshairs),
                                color: Colors.white,
                                onPressed: () {
                                  if(mapController != null){
                                    mapController?.animateCamera(CameraUpdate.newLatLngZoom(widget.startLocation!, 20.0));
                                  }
                                },
                              ))),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: CustomColor.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                topLeft: Radius.circular(10.r))),
                        padding: EdgeInsets.all(15.w),
                        width: double.infinity,
                        child: Column(
                          children: [
                            ListTile(
                              leading:FaIcon(FontAwesomeIcons.mapLocationDot,color: CustomColor.primary500,size: 25.w,),
                              title: Text(
                                location,
                                style: CustomTextStyle.reguler12,
                              ),
                              dense: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            ButtonPrimary(click: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.pop(context,cameraPosition?.target);
                              });
                            }, teks: "Pilih Lokasi")
                          ],
                        )),
                  ],
                ))
          ])),
    );
  }
}