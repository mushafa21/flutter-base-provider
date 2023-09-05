import 'package:flutter/material.dart';
import 'package:flutter_base_project/ui/home/widget/game_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_dialog.dart';
import '../../utils/go.dart';
import '../../widget/view_kosong.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(context),
      child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              Widget listViewGame() {
                if (provider.listGame.isEmpty == true) {
                  return ViewKosong();
                } else {
                  return ListView.builder(itemBuilder: (context, index) {
                    return GameItem(data: provider.listGame[index]);
                  },
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.listGame.length,
                    shrinkWrap: true,);
                }
              }

              Widget viewMain() {
                return RefreshIndicator(
                  onRefresh: () {
                    provider.page = 1;
                    provider.getGame();
                    return Future.value();
                  },
                  child: SingleChildScrollView(
                    controller: provider.scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listViewGame()
                        ],
                      ),
                    ),
                  ),
                );
              }


              return Scaffold(
                body: SafeArea(child: viewMain()),
              );
            },
          ),
    );
  }


  // observeData() {
  //   if (provider?.isLoading == true) {
  //     print("loading");
  //     dialog?.showLoading();
  //   } else {
  //     print("no loading");
  //     dialog?.dismiss();
  //   }
  // }





}

