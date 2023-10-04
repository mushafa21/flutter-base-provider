import 'package:flutter/material.dart';
import 'package:flutter_base_project/model/game_model.dart';
import 'package:flutter_base_project/styles/custom_colors.dart';
import 'package:flutter_base_project/styles/custom_text_styles.dart';
import 'package:flutter_base_project/ui/detail_game/detail_game_view.dart';
import 'package:flutter_base_project/widget/image_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/go.dart';


class GameItem extends StatelessWidget {
  final GameModel data;
  const GameItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Go().move(context: context, target: DetailGamePage(idGame: data.id ?? 0,));
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.gray400,),
          borderRadius: BorderRadius.circular(10.w)
        ),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            ImageView(url: data.backgroundImage ?? "",width: 50.w,height: 50.w,fit: BoxFit.cover,),
            SizedBox(width: 10.w,),
            Expanded(child: Text(data.name ?? "",style: CustomTextStyles.semiBold12,))
          ],
        ),
      ),
    );
  }
}
