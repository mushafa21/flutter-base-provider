import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final int itemCount;
  final int axisCount;
  final double? margin;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext,int) itemBuilder;
  const CustomGridView({super.key, required this.itemCount, required this.itemBuilder, required this.axisCount, this.margin, this.physics});

  @override
  Widget build(BuildContext context) {
    List<Widget> listRow = [];
    List<Widget> listWidgetMenu = [];

    for(var i = 0 ; i < itemCount ; i++){
      listWidgetMenu.add(Expanded(child: itemBuilder(context,i)));
      if(listWidgetMenu.length == axisCount){
        listRow.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listWidgetMenu,
            ));
        listWidgetMenu = [];
      }

      if(i == itemCount - 1 && listWidgetMenu.length > 0){
        var times = (axisCount - listWidgetMenu.length);
        for (var i = 0 ; i < times; i++){
          listWidgetMenu.add(Expanded(child: Container()));
        }
        listRow.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listWidgetMenu,
            ));
      }

    }




    return SingleChildScrollView(
      physics: physics ?? AlwaysScrollableScrollPhysics(),
      child: Column(
        children: listRow,
      ),
    );
  }
}
