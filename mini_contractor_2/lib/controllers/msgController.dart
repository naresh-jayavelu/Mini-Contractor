import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/message.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/views/message.dart';

class MessageController{
    Future<List<Message>> fetchWorkOrders(String userId, BuildContext context) async {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();
      var userid=userData['id'];

    try {
      final response = await http.get(Uri.parse('$url/messege/$userid')); 

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<Message> workOrders = decodedList
            .map((model) => Message.fromJson(model))
            .toList();
        
        return workOrders;
      } else {
        print("Error fetching work orders: ${response.statusCode}");
        print("Failed URL: $url/workorder");
        message("Failed to load work order", false,context);
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
        message("Failed to load work order", false,context);
      throw Exception(error);
    }
  }
Future<void> message(String data,bool type, BuildContext context) async {
  Future.microtask(() {
    showDialog(
      context: context,
      builder: (_) => StatusDialog(success: type, data: data),
    );
  });
}

}