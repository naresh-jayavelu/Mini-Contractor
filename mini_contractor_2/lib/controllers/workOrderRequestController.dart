import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/models/workOrderRequest.dart';
import 'package:mini_contractor_2/views/message.dart';

class WorkOrderRequestController {
  List<WorkOrderAssignment> _requests = [];

  void clearData() {
    _requests.clear();
  }

  Future<List<WorkOrderAssignment>> fetchrequests(BuildContext context) async {
    var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId = userData['id'];
    var usertype = userData['type'];
    var type = '';
    print(usertype);
    if (usertype == contractorCode) {
      type = "Contractor";
    } else {
      type = "Client";
    }
    print(type);
    try {
      final response = await http.get(Uri.parse('$url/workOrderAssigments/$userId/$type'));
      print('$url/workOrderAssigments/$userId/$type');
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body);

        List<WorkOrderAssignment> workOrders = decodedList
            .map((model) => WorkOrderAssignment.fromJson(model))
            .toList();

        _requests = workOrders; // Store fetched data in _requests list

        return workOrders;
      } else {
        print("Error fetching work orders: ${response.statusCode}");
        print("Failed URL: $url/workorder");
        message("Failed to load work order", false, context);
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
      message("Failed to load work order", false, context);
      throw Exception(error);
    }
  }

  Future<void> AcceptRequest(BuildContext context, String Id) async {
    try {
      final response = await http.put(Uri.parse('$url/acceptRequest/$Id/'));
      if (response.statusCode == 200) {
        message("Request sent successfully !!!", true, context);
      } else {
        print("Error fetching work orders: ${response.statusCode}");
        print("Failed URL: $url/workorder");
        message("Failed to load work order", false, context);
        throw Exception('Failed to load work order');
      }
    } catch (error) {
      print("Error fetching work orders: $error");
      message("Failed to load work order", false, context);
      throw Exception(error);
    }
  }

  Future<void> message(String data, bool type, BuildContext context) async {
    Future.microtask(() {
      showDialog(
        context: context,
        builder: (_) => StatusDialog(success: type, data: data),
      );
    });
  }
}
