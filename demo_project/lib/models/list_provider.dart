import 'package:flutter/material.dart';

import 'package:demo_project/models/list_data.dart';

class listProvider extends ChangeNotifier{
  final _list=listData();
  bool isLoding=false;
  List<dynamic>_userList=[];
  List<dynamic> get userList => _userList;

  Future<void> getAll() async{
    isLoding=true;
    notifyListeners();

    final response = await _list.getListData();

    _userList= response;
    isLoding=false;
    notifyListeners();
  }
}