import 'package:flutter/cupertino.dart';

class googleprovider extends ChangeNotifier
{
  double progress = 0;
  String searchText = '';
  String? url;
  String? urlhistory;

  void onchangeProgress(int progress) {
    this.progress = progress / 100;
    notifyListeners();
  }

  void search(String searchText){
    this.searchText = searchText;
    notifyListeners();
  }

  void addurl(String string) {}


}