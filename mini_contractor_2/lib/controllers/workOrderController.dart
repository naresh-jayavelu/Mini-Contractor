import 'dart:convert';

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/WorkOrderAssigment.dart';
import 'package:mini_contractor_2/models/WorkOrderjoin.dart';
import 'package:mini_contractor_2/models/message.dart';
import 'package:mini_contractor_2/models/workOrderModel.dart'; // Update import statement
import 'package:mini_contractor_2/views/message.dart';
import 'package:url_launcher/url_launcher.dart';
class WorkOrderController {

Future<String> isfirst(String Workorderid) async {
  
  var secureStorage = SecureStorageService();
  var userData = await secureStorage.getUserData();
  var userId=userData['id']??'';
   final response = await http.get(Uri.parse('$url/isFirst/$Workorderid/$userId')); 
      print("hii");
      if (response.statusCode == 200) {
        print("hiii");
        return "true";
        }
  return "false";
}
  
void launchMaps(String latitude, String longitude, BuildContext context) async {
  try {
    double lat = double.parse(latitude);
    double long = double.parse(longitude);
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    Uri uri = Uri.parse(googleUrl);
    await launchUrl(uri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // throw 'Could not open the map.';
    }
  } catch (e) {
    // Handle any potential errors here
    print('Error launching maps: $e');
    message("Failed to open maps", false, context);
  }
}


// void launchMaps(String latitude, String longitude,BuildContext context) async {
//   // Construct the maps URL with the latitude and longitude
//   final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

//   // Check if the URL can be launched
//   // ignore: deprecated_member_use
//   if (await canLaunch(url)) {
//     // Launch the maps URL
//     await launch(url);
//   } else {
//     message("Failed to load work order", false,context);
//     throw 'Could not launch $url';
//   }
// }

Future<WorkOrderJoin> fetchworkorderdetails(workOrderId,BuildContext context) async{
  try{
    final response=await http.get(Uri.parse('$url/workorderJoin/$workOrderId'));
    if (response.statusCode==200){
      final dynamic decodedData=jsonDecode(response.body);
      var  a=WorkOrderJoin.fromJson(decodedData);
      print(a.estimatedAmount);
        // message("Failed to load work order", false,context);
      return WorkOrderJoin.fromJson(decodedData);
    }else {
      print("Error: ${response.statusCode}");
        message("Failed to load work order", false,context);
      throw Exception('Failed to load work order');
    }
    
  }catch(err){
    print(err);
    throw Exception('failed to load the data');
  }
}

// Future<workOrder> fetchWorkOrder(workOrderID) async {
//   try {
//     final response = await http.get(Uri.parse('$url/workorder/$workOrderID/'));

//     if (response.statusCode == 200) {
//       final dynamic decodedData = jsonDecode(response.body);

//       // If the response is an object (not a list), directly convert it to a workOrder instance
//       if (decodedData is Map<String, dynamic>) {
//         return workOrder.fromJson(decodedData);
//       }

//       // If the response is a list, return the first item
//       if (decodedData is List<dynamic> && decodedData.isNotEmpty) {
//         return workOrder.fromJson(decodedData.first);
//       }

//       throw Exception('Invalid response format');
//     } else {
//       print("Error: ${response.statusCode}");
//       throw Exception('Failed to load work order');
//     }
//   } catch (error) {
//     print("Error fetching work order: $error");
//     throw Exception('Failed to load work order');
//   }
// }
  Future<List<workOrder>> fetchWorkOrders(BuildContext context) async {
    print("hdf");
    try {
      final response = await http.get(Uri.parse('$url/workorder')); 

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<workOrder> workOrders = decodedList
            .map((model) => workOrder.fromJson(model))
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

  Future<String> fetchJobType(String jobTypeId,BuildContext context) async {
    try {
      print(jobTypeId);
      final response = await http.get(Uri.parse('$url/jobType/$jobTypeId')); 

      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        print("Error fetching job type: ${response.statusCode}");
        print("Failed URL: $url/jobtype/$jobTypeId");
        message("Failed to load work order", false,context);
        throw Exception('Failed to load job type');
      }
    } catch (error) {
      print("Error fetching job type: $error");
        message("Failed to load work order", false,context);
      throw Exception(error);
    }
  }

  Future<void> sendRequest(String workId, String userId, BuildContext context) async {
    try {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();

      

      var workOrderAssigment = WorkOrderAssignment(
        workOrderId: workId,
        contractorId: userData['id'] ?? '',
        requestStatus: 'Requested',
        responseStatus: 'Waiting',
      );

      var workOrderAssigmentJson = workOrderAssigment.toJson();
      
      final response = await http.post(
        Uri.parse('$url/workOrderAssigment'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(workOrderAssigmentJson),
      );

      if (response.statusCode == 200) {
        print('Request sent successfully');
        message("Request sent", true, context);
      } else {
        print('Failed to send request. Status code: ${response.statusCode}');
        message("Failed to send request", false, context);
      }

      var message2 = Messagesend(
        text: "Hii, I am interested in the project. If you're free, we can talk more...",
        actionedOn: userId,
        documentId: '', 
        userId: userData['id'] ?? '', 
        workOrder: workId,
      );

      var messageJson = message2.toJson();

      final messageResponse = await http.post(
        Uri.parse('$url/messagesend'),
        body: jsonEncode(messageJson),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (messageResponse.statusCode == 200) {
        print('Request sent successfully');
        message("Request sent", true, context);
      } else {
        print('Failed to send request. Status code: ${messageResponse.statusCode}');
        message("Failed to send request", false, context);
      }
    } catch (error) {
      print('Error sending request: $error');
      message("Failed to send request", false, context);
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

Future<List<workOrder>> fetchMyOrders(BuildContext context) async {
    print("hdf");
    try {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();
      var id=userData['id'] ;
      final response = await http.get(Uri.parse('$url/workorder/$id')); 

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);
        
        List<workOrder> workOrders = decodedList
            .map((model) => workOrder.fromJson(model))
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
void updateworkorder(String id, String text, String type, BuildContext context) async {
  try {
    final response = await http.put(
      Uri.parse('$url/workOrderUpdate/$id/$type/$text/'),
    );
    if (response.statusCode == 200) {
      // Successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Project updated successfully'),
        ),
      );
      // setState(() {});
    } else {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Project not found'),
        ),
      );
    }
  } catch (e) {
    print('Error: $e');
    // Handle error gracefully
  }
}

}