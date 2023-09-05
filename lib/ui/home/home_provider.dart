import 'package:flutter/material.dart';

import '../../firebase/firebase_send.dart';
import '../../model/game_model.dart';
import '../../repository/games_repo.dart';
import '../../utils/custom_dialog.dart';
import '../../utils/log.dart';

class HomeProvider extends ChangeNotifier {
  final GameRepo _repo = GameRepo();
  CustomDialog? dialog;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int itemPerPage = 10;
  bool endPage = false;

  List<GameModel> listGame = [];

  HomeProvider(BuildContext context){
    dialog = CustomDialog(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getGame();
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          if (!endPage) {
            page += 1;
            getGame();
          }
        }
      });
    });


  }

  getGame() async {
    isLoading = true;
    dialog?.showLoading();
    try {
      final response = await _repo.listGame(page);
      if(page == 1){
        listGame = response.results ?? [];
      } else{
        listGame.addAll(response.results ?? []);
      }

      if((response.results?.length ?? 0) < itemPerPage){
        endPage = true;
      }
      isLoading = false;
      dialog?.dismiss();

    } catch (e) {
      isLoading = false;
      dialog?.dismiss();
      if(e.runtimeType != String){
        dialog?.error(message: "Terjadi Kesalahan, Silahkan coba beberapa saat lagi");
        LogMessage().log(lokasi: "Home", message:e.toString());
        FirebaseSend().send(lokasi: runtimeType.toString(), message: e.toString());
      } else{
        dialog?.error(message: e.toString());
      }
    }



    notifyListeners();


  }


}
