class workOrder {
  final String Id;
  final String description;
  final String estimatedAmount;
  final String status;
  final String estimatedStartDate;
  final String estimatedEndDate;
  final bool isAssigned;
  final bool isActive;
  final String document;
  final String jobTypeId;
  final String expertiseId;
  final String clientId;
  final String addressId;

  workOrder({
    required this.Id,
    required this.description,
    required this.estimatedAmount,
    required this.status,
    required this.estimatedStartDate,
    required this.estimatedEndDate,
    required this.isAssigned,
    required this.isActive,
    required this.document,
    required this.jobTypeId,
    required this.expertiseId,
    required this.clientId,
    required this.addressId,
  });

  factory workOrder.fromJson(Map<String, dynamic> json) {
    return workOrder(
      Id: json['Id'] ?? '',
      description: json['description'] ?? '',
      estimatedAmount: json['estimatedAmount'] ?? '',
      status: json['status'] ?? '',
      estimatedStartDate: json['estimatedStartDate'] ?? '',
      estimatedEndDate: json['estimatedEndDate'] ?? '',
      isAssigned: json['isAssigned'] ?? false,
      isActive: json['isActive'] ?? false,
      document: json['document'] ?? '',
      jobTypeId: json['jobTypeId'] ?? '',
      expertiseId: json['expertiseId'] ?? '',
      clientId: json['clientId'] ?? '',
      addressId: json['addressId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'description': description,
      'estimatedAmount': estimatedAmount,
      'status': status,
      'estimatedStartDate': estimatedStartDate,
      'estimatedEndDate': estimatedEndDate,
      'isAssigned': isAssigned,
      'isActive': isActive,
      'document': document,
      'jobTypeId': jobTypeId,
      'expertiseId': expertiseId,
      'clientId': clientId,
      'addressId': addressId,
    };
  }
}

// class workOrder {
//   final String Id;
//   final String expertiseType;
//   final String amount;
//   final String completionTime;
//   final String description;
//   final String addressId; // Add missing field
//   final String documentMappingID; // Add missing field
//   final String jobTypeId; // Add missing field
//   final String expertiseId; // Add missing field
//   final String status; // Add missing field
//   final String estimatedStartDate; // Add missing field
//   final bool isAssigned;
//   final bool isActive;

//   const workOrder({
//     required this.Id,
//     required this.expertiseType,
//     required this.amount,
//     required this.completionTime,
//     required this.description,
//     required this.addressId,
//     required this.documentMappingID,
//     required this.jobTypeId,
//     required this.expertiseId,
//     required this.status,
//     required this.estimatedStartDate,
//     required this.isAssigned,
//     required this.isActive,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'Id': Id,
//       'expertiseType': expertiseType,
//       'amount': amount,
//       'completionTime': completionTime,
//       'description': description,
//       'addressId': addressId,
//       'documentMappingID': documentMappingID,
//       'jobTypeId': jobTypeId,
//       'expertiseId': expertiseId,
//       'status': status,
//       'estimatedStartDate': estimatedStartDate,
//       'isAssigned': isAssigned,
//       'isActive': isActive,
//     };
//   }

//   factory workOrder.fromJson(Map<String, dynamic> json) {
//     return workOrder(
//       Id: json['Id'] ?? '',
//       expertiseType: json['expertiseType'] ?? '',
//       amount: json['estimatedAmount'] ?? '',
//       completionTime: json['completionTime'] ?? '',
//       description: json['description'] ?? '',
//       addressId: json['addressId'] ?? '',
//       documentMappingID: json['documentMappingID'] ?? '',
//       jobTypeId: json['jobTypeId'] ?? '',
//       expertiseId: json['expertiseId'] ?? '',
//       status: json['status'] ?? '',
//       estimatedStartDate: json['estimatedStartDate'] ?? '',
//       isAssigned: json['isAssigned'] ?? false,
//       isActive: json['isActive'] ?? false,
//     );
//   }
// }



// // class workOrder{

// //     final String jobType ;
// //     final String expertiseType;
// //     final String amount;
// //     final String completionTime;
// //     final String description;
// //     final String Id;

// //   const workOrder({
// //     required this.jobType, 
// //     required this.expertiseType,
// //     required this.amount,
// //     required this.completionTime,
// //     required this.description,
// //     required this.Id,
// //     });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'Id':Id,
// //       'jobType': jobType,
// //       'expertiseType': expertiseType,
// //       'amount': amount,
// //       'completionTime': completionTime,
// //       'description': description,
// //     };
// //   }
// //   factory workOrder.fromJson(Map<String, dynamic> json) {
// //     return workOrder(
// //       Id: json['Id']??'',
// //       addressId: json['addressId'] ?? '',
// //       documentMappingID: json['documentMappingID'] ?? '',
// //       jobTypeId: json['jobTypeId'] ?? '',
// //       expertiseId: json['expertiseId'] ?? '',
// //       amount: json['estimatedAmount'] ?? '',
// //       estimatedcompletionDate: json['estimatedEndDate'] ?? '',
// //       description: json['description'] ?? '',
// //       status:json['status']??'',
// //       estimatedStartDate:json['estimatedStartDate']??'',
// //       isAssigned:json['isAssigned'] ??false,
// //       isActive:json['isActive'] ??true,
// //     );
// //   }}



// // class workOrder {
// //   final String Id;
// //   final String jobType;
// //   final String expertiseType;
// //   final String amount;
// //   final String completionTime;
// //   final String description;

// //   const workOrder({
// //     required this.Id,
// //     required this.jobType,
// //     required this.expertiseType,
// //     required this.amount,
// //     required this.completionTime,
// //     required this.description,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'Id':Id,
// //       'jobType': jobType,
// //       'expertiseType': expertiseType,
// //       'amount': amount,
// //       'completionTime': completionTime,
// //       'description': description,
// //     };
// //   }

// //   factory workOrder.fromJson(Map<String, dynamic> json) {
// //     return workOrder(
// //       Id: json['Id']??'',
// //       jobType: json['jobTypeId'] ?? '',
// //       expertiseType: json['expertiseId'] ?? '',
// //       amount: json['estimatedAmount'] ?? '',
// //       completionTime: json['estimatedEndDate'] ?? '',
// //       description: json['description'] ?? '',
// //     );
// //   }
// // }



// // import 'dart:convert';

// // class workOrder {
// //   final String id;
// //   final String description;
// //   final String estimatedAmount;
// //   final String status;
// //   final String estimatedStartDate;
// //   final String estimatedEndDate;
// //   final String documentMappingId;
// //   final String jobTypeId;
// //   final String expertiseId;
// //   final String addressId;
// //   final bool isAssigned;
// //   final bool isActive;

// //   const workOrder({
// //     required this.id,
// //     required this.description,
// //     required this.estimatedAmount,
// //     required this.status,
// //     required this.estimatedStartDate,
// //     required this.estimatedEndDate,
// //     required this.documentMappingId,
// //     required this.jobTypeId,
// //     required this.expertiseId,
// //     required this.addressId,
// //     required this.isAssigned,
// //     required this.isActive,
// //   });

// //   factory workOrder.fromJson(Map<String, dynamic> json) {
// //     return workOrder(
// //       id: json['id'] ?? '',
// //       description: json['description'] ?? '',
// //       estimatedAmount: json['estimatedAmount'] ?? '',
// //       status: json['status'] ?? '',
// //       estimatedStartDate: json['estimatedStartDate'] ?? '',
// //       estimatedEndDate: json['estimatedEndDate'] ?? '',
// //       documentMappingId: json['documentMapping'],
// //       jobTypeId: json['jobTypeId'],
// //       expertiseId: json['expertiseId'],
// //       addressId: json['addressId'],
// //       isAssigned: json['isAssigned'] ?? false,
// //       isActive: json['isActive'] ?? false,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'description': description,
// //       'estimatedAmount': estimatedAmount,
// //       'status': status,
// //       'estimatedStartDate': estimatedStartDate,
// //       'estimatedEndDate': estimatedEndDate,
// //       'documentMappingId': documentMappingId,
// //       'jobTypeId': jobTypeId,
// //       'expertiseId': expertiseId,
// //       'addressId': addressId,
// //       'isAssigned': isAssigned,
// //       'isActive': isActive,
// //     };
// //   }
// // }

// // class Role {
// //   final String roleCode;
// //   final String roleName;
// //   final String roleDescription;
// //   final bool isActive;
// //   final String id;

// //   Role({
// //     required this.roleCode,
// //     required this.roleName,
// //     required this.roleDescription,
// //     this.isActive = true,
// //     required this.id,
// //   });

// //   factory Role.fromJson(Map<String, dynamic> json) {
// //     return Role(
// //       roleCode: json['RoleCode'] ?? '',
// //       roleName: json['RoleName'] ?? '',
// //       roleDescription: json['RoleDescription'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       id: json['id'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'RoleCode': roleCode,
// //       'RoleName': roleName,
// //       'RoleDescription': roleDescription,
// //       'isActive': isActive,
// //       'id': id,
// //     };
// //   }
// // }

// // class Gender {
// //   final String genderCode;
// //   final String genderName;
// //   final String genderDescription;
// //   final bool isActive;
// //   final String genderId;

// //   Gender({
// //     required this.genderCode,
// //     required this.genderName,
// //     required this.genderDescription,
// //     this.isActive = true,
// //     required this.genderId,
// //   });

// //   factory Gender.fromJson(Map<String, dynamic> json) {
// //     return Gender(
// //       genderCode: json['genderCode'] ?? '',
// //       genderName: json['genderName'] ?? '',
// //       genderDescription: json['genderDescription'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       genderId: json['genderId'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'genderCode': genderCode,
// //       'genderName': genderName,
// //       'genderDescription': genderDescription,
// //       'isActive': isActive,
// //       'genderId': genderId,
// //     };
// //   }
// // }

// // class DocumentType {
// //   final String documentTypeId;
// //   final String code;
// //   final String name;
// //   final String description;
// //   final bool isActive;

// //   DocumentType({
// //     required this.documentTypeId,
// //     required this.code,
// //     required this.name,
// //     required this.description,
// //     this.isActive = true,
// //   });

// //   factory DocumentType.fromJson(Map<String, dynamic> json) {
// //     return DocumentType(
// //       documentTypeId: json['documentTypeId'] ?? '',
// //       code: json['code'] ?? '',
// //       name: json['name'] ?? '',
// //       description: json['description'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'documentTypeId': documentTypeId,
// //       'code': code,
// //       'name': name,
// //       'description': description,
// //       'isActive': isActive,
// //     };
// //   }
// // }

// // class Document {
// //   final String documentId;
// //   final String file;
// //   final DocumentType documentTypeId;
// //   final bool isActive;

// //   Document({
// //     required this.documentId,
// //     required this.file,
// //     required this.documentTypeId,
// //     this.isActive = true,
// //   });

// //   factory Document.fromJson(Map<String, dynamic> json) {
// //     return Document(
// //       documentId: json['documentId'] ?? '',
// //       file: json['file'] ?? '',
// //       documentTypeId: DocumentType.fromJson(json['documentTypeId']),
// //       isActive: json['isActive'] ?? true,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'documentId': documentId,
// //       'file': file,
// //       'documentTypeId': documentTypeId.toJson(),
// //       'isActive': isActive,
// //     };
// //   }
// // }

// // class JobType {
// //   final String jobTypeCode;
// //   final String jobTypeName;
// //   final String jobTypeDescription;
// //   final bool isActive;
// //   final String jobTypeId;

// //   JobType({
// //     required this.jobTypeCode,
// //     required this.jobTypeName,
// //     required this.jobTypeDescription,
// //     this.isActive = true,
// //     required this.jobTypeId,
// //   });

// //   factory JobType.fromJson(Map<String, dynamic> json) {
// //     return JobType(
// //       jobTypeCode: json['jobTypeCode'] ?? '',
// //       jobTypeName: json['jobTypeName'] ?? '',
// //       jobTypeDescription: json['jobTypeDescription'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       jobTypeId: json['jobTypeId'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'jobTypeCode': jobTypeCode,
// //       'jobTypeName': jobTypeName,
// //       'jobTypeDescription': jobTypeDescription,
// //       'isActive': isActive,
// //       'jobTypeId': jobTypeId,
// //     };
// //   }
// // }

// // class Expertise {
// //   final String expertiseCode;
// //   final String expertiseName;
// //   final String expertiseDescription;
// //   final bool isActive;
// //   final String expertiseId;

// //   Expertise({
// //     required this.expertiseCode,
// //     required this.expertiseName,
// //     required this.expertiseDescription,
// //     this.isActive = true,
// //     required this.expertiseId,
// //   });

// //   factory Expertise.fromJson(Map<String, dynamic> json) {
// //     return Expertise(
// //       expertiseCode: json['expertiseCode'] ?? '',
// //       expertiseName: json['expertiseName'] ?? '',
// //       expertiseDescription: json['expertiseDescription'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       expertiseId: json['expertiseId'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'expertiseCode': expertiseCode,
// //       'expertiseName': expertiseName,
// //       'expertiseDescription': expertiseDescription,
// //       'isActive': isActive,
// //       'expertiseId': expertiseId,
// //     };
// //   }
// // }

// // class Address {
// //   final String addressLine1;
// //   final String addressLine2;
// //   final String pincode;
// //   final String city;
// //   final String state;
// //   final String country;
// //   final String latitude;
// //   final String longitude;
// //   final bool isActive;
// //   final String addressId;

// //   Address({
// //     required this.addressLine1,
// //     required this.addressLine2,
// //     required this.pincode,
// //     required this.city,
// //     required this.state,
// //     required this.country,
// //     required this.latitude,
// //     required this.longitude,
// //     this.isActive = true,
// //     required this.addressId,
// //   });

// //   factory Address.fromJson(Map<String, dynamic> json) {
// //     return Address(
// //       addressLine1: json['addressLine1'] ?? '',
// //       addressLine2: json['addressLine2'] ?? '',
// //       pincode: json['pincode'] ?? '',
// //       city: json['city'] ?? '',
// //       state: json['state'] ?? '',
// //       country: json['country'] ?? '',
// //       latitude: json['latitude'] ?? '',
// //       longitude: json['longitude'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       addressId: json['addressId'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'addressLine1': addressLine1,
// //       'addressLine2': addressLine2,
// //       'pincode': pincode,
// //       'city': city,
// //       'state': state,
// //       'country': country,
// //       'latitude': latitude,
// //       'longitude': longitude,
// //       'isActive': isActive,
// //       'addressId': addressId,
// //     };
// //   }
// // }

// // class User {
// //   final String userId;
// //   final String email;
// //   final String firstName;
// //   final String lastName;
// //   final String password;
// //   final String dob;
// //   final String phone;
// //   final String status;
// //   final bool isActive;
// //   final Role roleId;
// //   final Address addressId;
// //   final Gender genderId;

// //   User({
// //     required this.userId,
// //     required this.email,
// //     required this.firstName,
// //     required this.lastName,
// //     required this.password,
// //     required this.dob,
// //     required this.phone,
// //     required this.status,
// //     this.isActive = true,
// //     required this.roleId,
// //     required this.addressId,
// //     required this.genderId,
// //   });

// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       userId: json['userId'] ?? '',
// //       email: json['email'] ?? '',
// //       firstName: json['firstName'] ?? '',
// //       lastName: json['lastName'] ?? '',
// //       password: json['password'] ?? '',
// //       dob: json['dob'] ?? '',
// //       phone: json['phone'] ?? '',
// //       status: json['status'] ?? '',
// //       isActive: json['isActive'] ?? true,
// //       roleId: Role.fromJson(json['roleId']),
// //       addressId: Address.fromJson(json['addressId']),
// //       genderId: Gender.fromJson(json['genderId']),
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'userId': userId,
// //       'email': email,
// //       'firstName': firstName,
// //       'lastName': lastName,
// //       'password': password,
// //       'dob': dob,
// //       'phone': phone,
// //       'status': status,
// //       'isActive': isActive,
// //       'roleId': roleId.toJson(),
// //       'addressId': addressId.toJson(),
// //       'genderId': genderId.toJson(),
// //     };
// //   }
// // }

// // class DocumentMapping {
// //   final String documentMappingId;
// //   final Document documentId;
// //   final Role entityType;
// //   final User entityId;
// //   final bool isActive;

// //   DocumentMapping({
// //     required this.documentMappingId,
// //     required this.documentId,
// //     required this.entityType,
// //     required this.entityId,
// //     this.isActive = true,
// //   });

// //   factory DocumentMapping.fromJson(Map<String, dynamic> json) {
// //     return DocumentMapping(
// //       documentMappingId: json['documentMappingId'] ?? '',
// //       documentId: Document.fromJson(json['documentId']),
// //       entityType: Role.fromJson(json['entityType']),
// //       entityId: User.fromJson(json['entityId']),
// //       isActive: json['isActive'] ?? true,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'documentMappingId': documentMappingId,
// //       'documentId': documentId.toJson(),
// //       'entityType': entityType.toJson(),
// //       'entityId': entityId.toJson(),
// //       'isActive': isActive,
// //     };
// //   }
// // }

// // class ContractorWorkProfile {
// //   final String contractorWorkProfileId;
// //   final User contractorId;
// //   final JobType jobTypeId;
// //   final Expertise expertiseId;
// //   final DocumentMapping documentMappingId;
// //   final bool isActive;

// //   ContractorWorkProfile({
// //     required this.contractorWorkProfileId,
// //     required this.contractorId,
// //     required this.jobTypeId,
// //     required this.expertiseId,
// //     required this.documentMappingId,
// //     this.isActive = true,
// //   });

// //   factory ContractorWorkProfile.fromJson(Map<String, dynamic> json) {
// //     return ContractorWorkProfile(
// //       contractorWorkProfileId: json['contractorWorkProfileId'] ?? '',
// //       contractorId: User.fromJson(json['contractorId']),
// //       jobTypeId: JobType.fromJson(json['jobTypeId']),
// //       expertiseId: Expertise.fromJson(json['expertiseId']),
// //       documentMappingId: DocumentMapping.fromJson(json['documentMappingId']),
// //       isActive: json['isActive'] ?? true,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'contractorWorkProfileId': contractorWorkProfileId,
// //       'contractorId': contractorId.toJson(),
// //       'jobTypeId': jobTypeId.toJson(),
// //       'expertiseId': expertiseId.toJson(),
// //       'documentMappingId': documentMappingId.toJson(),
// //       'isActive': isActive,
// //     };
// //   }
// // }

// // class WorkOrder {
// //   final String id;
// //   final String description;
// //   final String estimatedAmount;
// //   final String status;
// //   final String estimatedStartDate;
// //   final String estimatedEndDate;
// //   final DocumentMapping documentMappingID;
// //   final JobType jobTypeId;
// //   final Expertise expertiseId;
// //   final Address addressId;
// //   final bool isAssigned;
// //   final bool isActive;

// //   WorkOrder({
// //     required this.id,
// //     required this.description,
// //     required this.estimatedAmount,
// //     required this.status,
// //     required this.estimatedStartDate,
// //     required this.estimatedEndDate,
// //     required this.documentMappingID,
// //     required this.jobTypeId,
// //     required this.expertiseId,
// //     required this.addressId,
// //     required this.isAssigned,
// //     required this.isActive,
// //   });

// //   factory WorkOrder.fromJson(Map<String, dynamic> json) {
// //     return WorkOrder(
// //       id: json['Id'] ?? '',
// //       description: json['description'] ?? '',
// //       estimatedAmount: json['estimatedAmount'] ?? '',
// //       status: json['status'] ?? '',
// //       estimatedStartDate: json['estimatedStartDate'] ?? '',
// //       estimatedEndDate: json['estimatedEndDate'] ?? '',
// //       documentMappingID: DocumentMapping


// // class DocumentMapping {
// //   // Define DocumentMapping properties
// //   final String documentProperty;

// //   const DocumentMapping({
// //     required this.documentProperty,
// //   });

// //   factory DocumentMapping.fromJson(Map<String, dynamic> json) {
// //     return DocumentMapping(
// //       documentProperty: json['documentProperty'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'documentProperty': documentProperty,
// //     };
// //   }
// // }

// // class JobType {
// //   // Define JobType properties
// //   final String jobTypeProperty;

// //   const JobType({
// //     required this.jobTypeProperty,
// //   });

// //   factory JobType.fromJson(Map<String, dynamic> json) {
// //     return JobType(
// //       jobTypeProperty: json['jobTypeProperty'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'jobTypeProperty': jobTypeProperty,
// //     };
// //   }
// // }

// // class Expertise {
// //   final String expertiseProperty;

// //   const Expertise({
// //     required this.expertiseProperty,
// //   });

// //   factory Expertise.fromJson(Map<String, dynamic> json) {
// //     return Expertise(
// //       expertiseProperty: json['expertiseProperty'] ?? '',
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'expertiseProperty': expertiseProperty,
// //     };
// //   }
// // }

// // Similarly, define the Expertise and Address classes with toJson and fromJson methods.


// // class workOrder {
// //   final String Id;
// //   final String jobType;
// //   final String expertiseType;
// //   final String amount;
// //   final String completionTime;
// //   final String description;

// //   const workOrder({
// //     required this.Id,
// //     required this.jobType,
// //     required this.expertiseType,
// //     required this.amount,
// //     required this.completionTime,
// //     required this.description,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'Id':Id,
// //       'jobType': jobType,
// //       'expertiseType': expertiseType,
// //       'amount': amount,
// //       'completionTime': completionTime,
// //       'description': description,
// //     };
// //   }

// //   factory workOrder.fromJson(Map<String, dynamic> json) {
// //     return workOrder(
// //       Id: json['Id']??'',
// //       jobType: json['jobTypeId'] ?? '',
// //       expertiseType: json['expertiseId'] ?? '',
// //       amount: json['estimatedAmount'] ?? '',
// //       completionTime: json['estimatedEndDate'] ?? '',
// //       description: json['description'] ?? '',
// //     );
// //   }
// // }



// // class workOrder{

// //     final String jobType ;
// //     final String expertiseType;
// //     final String amount;
// //     final String completionTime;
// //     final String description;

// //   const workOrder({
// //     required this.jobType, 
// //     required this.expertiseType,
// //     required this.amount,
// //     required this.completionTime,
// //     required this.description
// //     });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'jobType': jobType,
// //       'expertiseType': expertiseType,
// //       'amount': amount,
// //       'completionTime': completionTime,
// //       'description': description,
// //     };
// //   }

// //   factory workOrder.fromJson(Map<String, dynamic> json) {
// //     return switch (json) {
// //       {
// //         'jobType': String jobType,
// //         'expertiseType': String expertiseType,
// //         'amount': String amount,
// //         'completionTime': String completionTime,
// //         'description': String description,
// //       } =>
// //         workOrder(
// //          jobType: jobType,
// //          expertiseType: expertiseType,
// //          amount: amount,
// //          completionTime: completionTime,
// //          description: description,
// //         ),
// //       _ => throw const FormatException('Failed to load album.'),
// //     };
// //   }

// //   Object? get map => null;
// // }
