import 'package:flutter/material.dart';
import 'dart:convert';

class AddWorkOrderData {
  String description;
  String estimatedAmount;
  String status;
  String estimatedStartDate;
  String estimatedEndDate;
  String? document; // Assuming documentId is a string representing the ID
  String? jobTypeId; // Assuming jobTypeId is a string representing the ID
  String? expertiseId; // Assuming expertiseId is a string representing the ID
  String? clientId; // Assuming clientId is a string representing the ID
  String? addressId; // Assuming addressId is a string representing the ID
  bool isAssigned;
  bool isActive;

  AddWorkOrderData({
    required this.description,
    required this.estimatedAmount,
    required this.status,
    required this.estimatedStartDate,
    required this.estimatedEndDate,
    this.document,
    this.jobTypeId,
    this.expertiseId,
    this.clientId,
    this.addressId,
    required this.isAssigned,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'estimatedAmount': estimatedAmount,
      'status': status,
      'estimatedStartDate': estimatedStartDate,
      'estimatedEndDate': estimatedEndDate,
      'document': document,
      'jobTypeId': jobTypeId,
      'expertiseId': expertiseId,
      'clientId': clientId,
      'addressId': addressId,
      'isAssigned': isAssigned,
      'isActive': isActive,
    };
  }
}

// void main() {
//   // Example usage
//   WorkOrder2 order = WorkOrder2(
//     id: '1',
//     description: 'Some description',
//     estimatedAmount: '100',
//     status: 'Pending',
//     estimatedStartDate: '2024-03-27',
//     estimatedEndDate: '2024-04-27',
//     documentId: '123',
//     jobTypeId: '456',
//     expertiseId: '789',
//     clientId: '101',
//     addressId: '202',
//     isAssigned: true,
//     isActive: true,
//   );

//   print(order.toJson()); // Output JSON representation of the object
// }

// class AddWorkOrderData {
//   String description;
//   String estimatedAmount;
//   String status;
//   String estimatedStartDate; 
//   String estimatedEndDate;   
//   String? document;
//   String? jobTypeId;
//   String? expertiseId;
//   String? clientId;
//   String? addressId;
//   bool? isAssigned;
//   bool? isActive;

//   AddWorkOrderData({
//     required this.description,
//     required this.estimatedAmount,
//     required this.status,
//     required this.estimatedStartDate,
//     required this.estimatedEndDate,
//     this.document,
//     this.jobTypeId,
//     this.expertiseId,
//     this.clientId,
//     this.addressId,
//     this.isActive,
//     this.isAssigned,
//   });
//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//       'estimatedAmount': estimatedAmount,
//       'status': status,
//       'estimatedStartDate': estimatedStartDate,
//       'estimatedEndDate': estimatedEndDate,
//       'document': document,
//       'jobTypeId': jobTypeId,
//       'expertiseId': expertiseId,
//       'clientId': clientId,
//       'addressId': addressId,
//       'isAssigned': isAssigned,
//       'isActive': isActive,
//     };
//   }
// }
