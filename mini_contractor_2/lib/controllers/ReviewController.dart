import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/review.dart';
import 'package:mini_contractor_2/models/workOrderRequest.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/views/message.dart';

class ReviewAndComplaintsController{
  Future<List<WorkOrderAssignment>> fetchrequests(BuildContext context) async {
    var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId=userData['id'];
    var userType=userData['type']??'';
    print("haha");
    var type='';
    try {
      if (userType==contractorCode){
      type="Contractor";
    }
    else{
      type="Client";      
    }
      final response = await http.get(Uri.parse('$url/review/$userId/$type/')); 
      // print('$url/workOrderAssigments/$userId/$type');
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<WorkOrderAssignment> workOrders = decodedList
            .map((model) => WorkOrderAssignment.fromJson(model))
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
  Future<void>addReview(BuildContext context,String rating,String comment,String workOrderID,String workOrderAssigment)async {
    var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId=userData['id']??'';
    var userType=userData['type']??'';
    var review=Review(entityType: userType, entityId: userId, workOrderId: workOrderID, rating: rating, comment: comment);
    
      var reviewjson = review.toJson();
      try {
      final response = await http.post(
        Uri.parse('$url/addReview'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reviewjson),
      );

      if (response.statusCode == 200) {
        print('Request sent successfully');
       
      } else {
        print('Failed to send request. Status code: ${response.statusCode}');
        message("Failed to send request", false, context);
      }
      final response2 = await http.put(Uri.parse('$url/updateRequest/$workOrderAssigment/Completed/'));
      if (response2.statusCode == 200) {
        message("Request sent successfully !!!", true,context);
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
  Future<void>addComplaint(BuildContext context,String comment,String workOrderID,String workOrderAssigment)async {
     var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId=userData['id']??'';
    var userType=userData['type']??'';
    var review=Review(entityType: userType, entityId: userId, workOrderId: workOrderID, rating: "", comment: comment);
    
      var reviewjson = review.toJson();
      try {
      final response = await http.post(
        Uri.parse('$url/addReview'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reviewjson),
      );

      if (response.statusCode == 200) {
        print('Request sent successfully');
       
      } else {
        print('Failed to send request. Status code: ${response.statusCode}');
        message("Failed to send request", false, context);
      }
      final response2 = await http.put(Uri.parse('$url/updateRequest/$workOrderAssigment/Complaint/'));
      if (response2.statusCode == 200) {
        message("Complaint raised !!!", true,context);
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