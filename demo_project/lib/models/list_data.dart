import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class listData {

  // int? id;
  String? email;
  String? first_name;
  String? last_name;
  String? avatar;

  listData({this.first_name, this.email, this.last_name, this.avatar});





  Future<List<Map<String, dynamic>>> getListData() async {
    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      final List<dynamic> successList = result["data"];
      final List<Map<String, dynamic>> userList = [];

      successList.forEach((result) {
        final Map<String, dynamic> ListData = {
          // 'id':result['id'],
          'email': result['email'],
          'first_name': result['first_name'],
          'last_name': result['last_name'],
          'avatar': result['avatar'],
        };
        userList.add(ListData);

        print(ListData);

      });
     // notifyListeners();
      return userList;
    }
    else {
      throw Exception('Failed to fetch items !');
    }
  }
}