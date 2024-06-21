// import 'dart:js';
// import 'dart:js_interop';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/AddWorkOrderData.dart';
import 'package:mini_contractor_2/models/Address.dart';
import 'package:mini_contractor_2/models/Document.dart';
import 'package:mini_contractor_2/views/message.dart';

class AddWorkOrderController {
  
Future<List<Map<String, String>>> fetchExpertise() async {
  final response = await http.get(Uri.parse('$url/expertise'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map<Map<String, String>>((e) => {
      'id':e['expertiseId'] as String,
      'value':e['expertiseName'] as String,
    }).toList();
  } else {
    throw Exception('Failed to fetch expertise');
  }
}
 Future<List<Map<String, String>>> fetchJobTypes() async {
  final response = await http.get(Uri.parse('$url/jobType'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map<Map<String, String>>((e) => {
      'id': e['jobTypeId'] ?? '',
      'value': e['jobTypeName'] ?? '',
    }).toList();
  } else {
    throw Exception('Failed to fetch job types');
  }
}

  Future<void> submitWorkOrder(AddWorkOrderData workOrder, String? base64Image,Address address,BuildContext context) async {
    print('image$base64Image');
    try {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();

      var document =Document(file:base64Image!, documentTypeId: '0d44194d-a0e8-4fe6-9e44-77d3cf9c0a10', isActive: true);
      
      var documentdata = document.toJson();
      var addressids='';
      var documentid='';

      
      final response = await http.post(
        Uri.parse('$url/document'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(documentdata),
      );

      if (response.statusCode == 200) {
        print('Request sent successfully');
        // message("Request sent", true, context);
        var responseData = jsonDecode(response.body);
  // Process responseData as needed
  print('Response data: $responseData');
documentid=responseData;
      } else {
        print('Failed to send request. Status code: ${response.statusCode}');
        message("Failed to send doc", false, context);
      }
      // if (address.addressLine1!='' && address.latitude!=''){
      var addressdata = address.toJson();
      
      final response2 = await http.post(
        Uri.parse('$url/address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(addressdata),
      );

      if (response2.statusCode == 200) {
        print('Request sent successfully');
        // message("Request sent", true, context);
         var responseData = jsonDecode(response2.body);
         print('Response data: $responseData');
addressids=responseData;
      } else {
        print('Failed to send request. Status code: ${response2.statusCode}');
        message("Failed to send address", false, context);
      }
      workOrder.addressId=addressids;
      workOrder.clientId=userData['id'];
      workOrder.document=documentid;
      workOrder.status="Active";
      var workorderdata = workOrder.toJson();
      print(workorderdata);
      final response3 = await http.post(
        Uri.parse('$url/workorder2'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(workorderdata),
      );

      if (response3.statusCode == 200) {
        print('New Project is added successfully');
        message("New Project is added successfully", true, context);
        Navigator.of(context).pop();
        
      } else {
        print('Failed to send request. Status code: ${response3.statusCode}');
        message("Failed to send workorder", false, context);
      
      }
      
    } catch (error) {
      print('Error sending request: $error');
      message("Failed to send request", false, context);
    }


    print(workOrder.description);
    // print(workOrder.estimatedAmount);
    // print(workOrder.estimatedStartDate);
    // print(workOrder.estimatedEndDate);
    // print(workOrder.expertiseId);
    // print(workOrder.jobTypeId);
    // print(base64Image);
    print(address.addressLine1);
    print(address.longitude);
    print(address.latitude);
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
