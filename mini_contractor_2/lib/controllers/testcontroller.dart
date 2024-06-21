import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/messegeController.dart';
import 'package:mini_contractor_2/models/message.dart';

class TestchatController{
  Future<List<MessageList>> chatList() async{
    try {
      final response = await http.get(Uri.parse('$url/messege/91008c5f-6714-4d00-9658-5cb5f77c7876')); 

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
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
      throw Exception(error);
    }
  }

  Future<void> sendMessage(String message,String workOrderId,String userId,String actionedId) async {
        try{
        var message2 = Messagesend(
        text: message,
        actionedOn: actionedId,
        documentId: '', 
        userId: userId, 
        workOrder: workOrderId,
        );
      var messageJson = message2.toJson();
      // print(messageJson);
      final messageResponse = await http.post(
        Uri.parse('$url/messagesend'),
        body: jsonEncode(messageJson),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      }catch(error){
        print(error);
      }
      
  }
  
  Future<List<MessageData>> chat(String workOrderId,String userId) async{
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
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
      throw Exception(error);
    }
  }
  Future<void> login(String password, String email) async {
  try {
    final response = await http.get(Uri.parse('$url/login/?email=$email&password=$password'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final apiResponse = APIResponse.fromJson(jsonResponse);

      if (apiResponse.success) {
        print("success");
      } else {
        print(apiResponse.data);
      }
    } else {
      // print("HTTP Error: ${response.statusCode}");
    }
  } catch (e) {
    print('Error: $e');
  }
}

}

