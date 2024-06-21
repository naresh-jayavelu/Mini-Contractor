import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/message.dart';
import 'package:mini_contractor_2/views/message.dart';

class chatController{   
  Future<List<MessageList>> chatList(BuildContext context) async{
    var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId=userData['id'];
    try {
      final response = await http.get(Uri.parse('$url/messege/$userId')); 

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<MessageList> data = decodedList
            .map((model) => MessageList.fromJson(model))
            .toList();
        print(data);
        return data;
      } else {
        print("Error fetching work orders: ${response.statusCode}");
        print("Failed URL: $url/workorder");
        messege("Failed to load work order", false,context);
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
        messege("Failed to load work order", false,context);
      throw Exception(error);
    }
  }

  Future<void> sendMessage(String message,String workOrderId,String userId,String actionedId,BuildContext context) async {
    try {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();
      print(userData['id']);
      print(userData['id']==userId);
      if (userData['id']==userId){
        var message2 = Messagesend(
        text: message,
        actionedOn: actionedId,
        documentId: '', 
        userId: userId, 
        workOrder: workOrderId,
      );

      var messageJson = message2.toJson();
      print(messageJson);
      final messageResponse = await http.post(
        Uri.parse('$url/messagesend'),
        body: jsonEncode(messageJson),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (messageResponse.statusCode == 200) {
        print('Request sent successfully');
      } else {
        print('Failed to send request. Status code: ${messageResponse.statusCode}');
        // ignore: use_build_context_synchronously
        messege("Failed to send request", false, context);
      }
      }else{
         var message2 = Messagesend(
        text: message,
        actionedOn: userId,
        documentId: '', 
        userId: userData['id']??'', 
        workOrder: workOrderId,
      );

      var messageJson = message2.toJson();
      print(messageJson);
      final messageResponse = await http.post(
        Uri.parse('$url/messagesend'),
        body: jsonEncode(messageJson),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (messageResponse.statusCode == 200) {
        print('Request sent successfully');
      } else {
        print('Failed to send request. Status code: ${messageResponse.statusCode}');
        // ignore: use_build_context_synchronously
        messege("Failed to send request", false, context);
      }}
     
    } catch (error) {
      print('Error sending request: $error');
      messege("Failed to send request", false, context);
    }
  }
  
  Future<List<MessageData>> chat(String workOrderId,String userId, BuildContext context) async{
    print(workOrderId);
    try {
      final response = await http.get(Uri.parse('$url/orderMessege/$workOrderId/$userId'));
    

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<MessageData> data = decodedList
            .map((model) => MessageData.fromJson(model))
            .toList();
        print(data);
        return data;
      } else {
        print("Error fetching work orders: ${response.statusCode}");
        print("Failed URL: $url/workorder");
        messege("Failed to load work order", false,context);
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
        messege("Failed to load work order", false,context);
      throw Exception(error);
    }
  }
}
Future<void> messege(String data,bool type, BuildContext context) async {
  Future.microtask(() {
    showDialog(
      context: context,
      builder: (_) => StatusDialog(success: type, data: data),
    );
  });
}
