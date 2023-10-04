

import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/styles/custom_colors.dart';
import 'package:rich_console/rich_console.dart';


class LogMessage{
  void log({required String lokasi,required String message}){
    if(kDebugMode){
      printRich("$lokasi : $message",foreground: CustomColors.primary500);
    }
  }

}