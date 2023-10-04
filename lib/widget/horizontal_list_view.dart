import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final int itemCount;
  final double? margin;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext,int) itemBuilder;
  const HorizontalListView({super.key, required this.itemCount, required this.itemBuilder,  this.margin, this.physics});

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgetMenu = [];

    for(var i = 0 ; i < itemCount ; i++){
      listWidgetMenu.add(itemBuilder(context,i));


    }




    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      physics: physics ?? AlwaysScrollableScrollPhysics(),
      child: Row(
        children: listWidgetMenu,
      ),
    );
  }
}