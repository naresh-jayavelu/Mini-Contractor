class User {
  final String userId;

  const User({
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',);
  }
}


class WorkOrderJoin {
  final String Id;
  final String expertiseType;
  final String estimatedAmount;
  final String estimatedEndDate;
  final String description;
  final Address addressId;
  final Document document;
  final JobType jobTypeId;
  final Expertise expertiseId;
  final String status;
  final String estimatedStartDate;
  final bool isAssigned;
  final bool isActive;
  final User userId;

  WorkOrderJoin({
    required this.Id,
    required this.expertiseType,
    required this.estimatedAmount,
    required this.estimatedEndDate,
    required this.description,
    required this.addressId,
    required this.document,
    required this.jobTypeId,
    required this.expertiseId,
    required this.status,
    required this.estimatedStartDate,
    required this.isAssigned,
    required this.isActive,
    required this.userId,
  });

  factory WorkOrderJoin.fromJson(Map<String, dynamic> json) {
    return WorkOrderJoin(
      Id: json['Id'] ?? '',
      expertiseType: json['expertiseType'] ?? '',
      estimatedAmount: json['estimatedAmount'] ?? '',
      estimatedEndDate: json['estimatedEndDate'] ?? '',
      description: json['description'] ?? '',
      addressId: Address.fromJson(json['addressId'] ?? {}),
      document: Document.fromJson(json['document'] ?? {}),
      jobTypeId: JobType.fromJson(json['jobTypeId'] ?? {}),
      expertiseId: Expertise.fromJson(json['expertiseId'] ?? {}),
      status: json['status'] ?? '',
      estimatedStartDate: json['estimatedStartDate'] ?? '',
      isAssigned: json['isAssigned'] ?? false,
      isActive: json['isActive'] ?? false,
      userId: User.fromJson(json['clientId'] ?? {}),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'expertiseType': expertiseType,
      'estimatedAmount': estimatedAmount,
      'estimatedEndDate': estimatedEndDate,
      'description': description,
      'addressId': addressId.toJson(),
      'document': document.toJson(),
      'jobTypeId': jobTypeId.toJson(),
      'expertiseId': expertiseId.toJson(), 
      'status': status,
      'estimatedStartDate': estimatedStartDate,
      'isAssigned': isAssigned,
      'isActive': isActive,
      'userId':userId.toJson(),
    };
  }
}

class Address {
  final String addressId;
  final String addressLine1;
  final String addressLine2;
  final String pincode;
  final String city;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final bool isActive;

  const Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.addressId,
    required this.pincode,
    required this.state,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'pincode': pincode,
      'city': city,
      'state': state,
      'country': country,  // Assuming toJson is implemented in Address class
      'latitude': latitude,  // Assuming toJson is implemented in DocumentMapping class
      'longitude': longitude,  // Assuming toJson is implemented in JobType class
      'addressId': addressId,
      'isActive': isActive,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      city: json['city'] ?? '',
      addressId: json['addressId'] ??'',
      country: json['country'] ??'',
      state: json['state'] ??'',
      pincode: json['pincode'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}

class Expertise {
  final String expertiseCode;
  final String expertiseName;
  final String expertiseDescription;
  final bool isActive; // Change type to bool
  final String expertiseId;

  const Expertise({
    required this.expertiseCode,
    required this.expertiseName,
    required this.expertiseDescription,
    required this.expertiseId,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'expertiseCode': expertiseCode,
      'expertiseName': expertiseName,
      'expertiseDescription': expertiseDescription,
      'isActive': isActive,
      'expertiseId': expertiseId,
    };
  }

  factory Expertise.fromJson(Map<String, dynamic> json) {
    return Expertise(
      expertiseCode: json['expertiseCode'] ?? '',
      expertiseName: json['expertiseName'] ?? '',
      expertiseDescription: json['expertiseDescription'] ?? '',
      expertiseId: json['expertiseId'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }
}


class JobType {
  final String jobTypeCode;
  final String jobTypeName;
  final String jobTypeDescription;
  final bool isActive;
  final String jobTypeId;

  const JobType({
    required this.jobTypeCode,
    required this.jobTypeDescription,
    required this.jobTypeId,
    required this.jobTypeName,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'jobTypeCode': jobTypeCode,
      'jobTypeName': jobTypeName,
      'jobTypeDescription': jobTypeDescription,
      'isActive': isActive,
      'jobTypeId': jobTypeId,
    };
  }

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(
      jobTypeCode: json['jobTypeCode'] ?? '',
      jobTypeName: json['jobTypeName'] ?? '',
      jobTypeDescription: json['jobTypeDescription'] ?? '',
      jobTypeId: json['jobTypeId'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }
}

  class Document {
  final String documentId;
  final String file;
  final String documentTypeId;
  final bool isActive;

  Document({
    required this.documentId,
    required this.file,
    required this.documentTypeId,
    required this.isActive,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentId: json['documentId'],
      file: json['file'],
      documentTypeId: json['documentTypeId'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'file': file,
      'documentTypeId': documentTypeId,
      'isActive': isActive,
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
//       amount: json['amount'] ?? '',
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
