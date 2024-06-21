


class Message {
  final String messageId;
  final String text;
  final User actionedOn;
  final Document documentId;
  final User userId;
  final String workOrder; 

  const Message({
    required this.messageId,
    required this.text,
    required this.actionedOn,
    required this.documentId,
    required this.userId,
    required this.workOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'text': text,
      'actionedOn': actionedOn.toJson(),
      'documentId': documentId.toJson(),
      'userId': userId.toJson(),
      'workOrder': workOrder,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'] ?? '',
      text: json['text'] ?? '',
      actionedOn: User.fromJson(json['actionedOn']??{}),
      documentId: Document.fromJson(json['documentId']??{}),
      userId: User.fromJson(json['userId']??{}),
      workOrder: json['workOrder'] ?? '',
    );
  }
}

  class Document {
  final String documentId;
  final String file;

  Document({
    required this.documentId,
    required this.file,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      documentId: json['documentId'],
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'file': file,
    };
  }
}


class User {
  final String userId;
  final String firstName;

  const User({
    required this.userId,
    required this.firstName,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
    );
  }
}

class Messagesend {
  final String text;
  final String actionedOn;
  final String documentId;
  final String userId;
  final String workOrder;

  const Messagesend({
    required this.text,
    required this.actionedOn,
    required this.documentId,
    required this.userId,
    required this.workOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'actionedOn': actionedOn,
      'documentId': documentId,
      'userId': userId,
      'workOrder':workOrder,
    };
  }

  factory Messagesend.fromJson(Map<String, dynamic> json) {
    return Messagesend(
      text: json['text'] ?? '',
      actionedOn: json['actionedOn']??'',
      documentId: json['documentId']??'',
      userId: json['userId']??'',
      workOrder:json['workOrder']??'',
    );
  }
}

class MessageData {
  final String messageId;
  final ActionedOn actionedOn;
  final String? documentId; // Note: This field is nullable in JSON
  final UserId userId;
  final String text;
  final String time2;
  final String workOrder;

  MessageData({
    required this.messageId,
    required this.actionedOn,
    required this.userId,
    required this.text,
    required this.time2,
    required this.workOrder,
    this.documentId,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      messageId: json['messageId'],
      actionedOn: ActionedOn.fromJson(json['actionedOn']),
      documentId: json['documentId'],
      userId: UserId.fromJson(json['userId']),
      text: json['text'],
      time2: json['time2'],
      workOrder: json['workOrder'],
    );
  }

  get id => null;

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'actionedOn': actionedOn.toJson(),
      'documentId': documentId,
      'userId': userId.toJson(),
      'text': text,
      'time2': time2,
      'workOrder': workOrder,
    };
  }
}

class ActionedOn {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phone;
  final String status;
  final bool isActive;
  final String roolId;
  final String addressId;
  final String genderId;

  ActionedOn({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.dob,
    required this.phone,
    required this.status,
    required this.isActive,
    required this.roolId,
    required this.addressId,
    required this.genderId,
  });

  factory ActionedOn.fromJson(Map<String, dynamic> json) {
    return ActionedOn(
      userId: json['userId'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      dob: json['dob'],
      phone: json['phone'],
      status: json['status'],
      isActive: json['isActive'],
      roolId: json['roolId'],
      addressId: json['addressId'],
      genderId: json['genderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'dob': dob,
      'phone': phone,
      'status': status,
      'isActive': isActive,
      'roolId': roolId,
      'addressId': addressId,
      'genderId': genderId,
    };
  }
}

class UserId {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String dob;
  final String phone;
  final String status;
  final bool isActive;
  final String roolId;
  final String addressId;
  final String genderId;

  UserId({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.dob,
    required this.phone,
    required this.status,
    required this.isActive,
    required this.roolId,
    required this.addressId,
    required this.genderId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      userId: json['userId'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      dob: json['dob'],
      phone: json['phone'],
      status: json['status'],
      isActive: json['isActive'],
      roolId: json['roolId'],
      addressId: json['addressId'],
      genderId: json['genderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'dob': dob,
      'phone': phone,
      'status': status,
      'isActive': isActive,
      'roolId': roolId,
      'addressId': addressId,
      'genderId': genderId,
    };
  }
}


// class MessageData {
//   final String messageId;
//   final String text;
//   final User actionedOn;
//   final Document documentId;
//   final User userId;
//   final String workOrder; 

//   const MessageData({
//     required this.messageId,
//     required this.text,
//     required this.actionedOn,
//     required this.documentId,
//     required this.userId,
//     required this.workOrder,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'messageId': messageId,
//       'text': text,
//       'actionedOn': actionedOn.toJson(),
//       'documentId': documentId.toJson(),
//       'userId': userId.toJson(),
//       'workOrder': workOrder,
//     };
//   }

//   factory MessageData.fromJson(Map<String, dynamic> json) {
//     return MessageData(
//       messageId: json['messageId'] ?? '',
//       text: json['text'] ?? '',
//       actionedOn: User.fromJson(json['actionedOn']??{}),
//       documentId: Document.fromJson(json['documentId']??{}),
//       userId: User.fromJson(json['userId']??{}),
//       workOrder: json['workOrder'] ?? '',
//     );
//   }
// }

class MessageList {
  final String messageId;
  final WorkOrder workOrder;
  final String text;
  final String time2;
  final String actionedOn;
  final String? documentId;
  final String userId;

  MessageList({
    required this.messageId,
    required this.workOrder, 
    required this.text,
    required this.time2,
    required this.actionedOn,
    required this.documentId,
    required this.userId,
  });

  factory MessageList.fromJson(Map<String, dynamic> json) {
    return MessageList(
      messageId: json['messageId'],
      workOrder: WorkOrder.fromJson(json['workOrder']),
      text: json['text'],
      time2: json['time2'],
      actionedOn: json['actionedOn'],
      documentId: json['documentId'],
      userId: json['userId'],
    );
  }

  get id => null;
}

class WorkOrder {
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

  WorkOrder({
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

  factory WorkOrder.fromJson(Map<String, dynamic> json) {
    return WorkOrder(
      Id: json['Id'],
      description: json['description'],
      estimatedAmount: json['estimatedAmount'],
      status: json['status'],
      estimatedStartDate: json['estimatedStartDate'],
      estimatedEndDate: json['estimatedEndDate'],
      isAssigned: json['isAssigned'],
      isActive: json['isActive'],
      document: json['document'],
      jobTypeId: json['jobTypeId'],
      expertiseId: json['expertiseId'],
      clientId: json['clientId'],
      addressId: json['addressId'],
    );
  }
}

// class MessageList {
//   final String messageId;
//   final String text;
//   final User actionedOn;
//   final Document documentId;
//   final User userId;
//   final WorkOrder workOrder; 

//   const MessageList({
//     required this.messageId,
//     required this.text,
//     required this.actionedOn,
//     required this.documentId,
//     required this.userId,
//     required this.workOrder,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'messageId': messageId,
//       'text': text,
//       'actionedOn': actionedOn.toJson(),
//       'documentId': documentId.toJson(),
//       'userId': userId.toJson(),
//       'workOrder': workOrder.toJson(),
//     };
//   }

// factory MessageList.fromJson(Map<String, dynamic> json) {
//   return MessageList(
//     messageId: json['messageId'] ?? '',
//     text: json['text'] ?? '',
//     actionedOn: User.fromJson(json['actionedOn'] ?? {}),
//     documentId: Document.fromJson(json['documentId'] ?? {}),
//     userId: User.fromJson(json['userId'] ?? {}),
//     workOrder: WorkOrder.fromJson(json['workOrder'] ?? {}),
//   );
// }
 
// }


// class WorkOrder {
//   final String Id;
//   final String expertiseType;
//   final String estimatedAmount;
//   final String estimatedEndDate;
//   final String description;
//   final String status;
//   final String estimatedStartDate;
//   final bool isAssigned;
//   final bool isActive;

//   WorkOrder({
//     required this.Id,
//     required this.expertiseType,
//     required this.estimatedAmount,
//     required this.estimatedEndDate,
//     required this.description,
//     required this.status,
//     required this.estimatedStartDate,
//     required this.isAssigned,
//     required this.isActive,
//   });

//   factory WorkOrder.fromJson(Map<String, dynamic> json) {
//     return WorkOrder(
//       Id: json['Id'] ?? '',
//       expertiseType: json['expertiseType'] ?? '',
//       estimatedAmount: json['estimatedAmount'] ?? '',
//       estimatedEndDate: json['estimatedEndDate'] ?? '',
//       description: json['description'] ?? '',
//       status: json['status'] ?? '',
//       estimatedStartDate: json['estimatedStartDate'] ?? '',
//       isAssigned: json['isAssigned'] ?? false,
//       isActive: json['isActive'] ?? false,
//     );
//   }

//     Map<String, dynamic> toJson() {
//     return {
//       'Id': Id,
//       'expertiseType': expertiseType,
//       'estimatedAmount': estimatedAmount,
//       'estimatedEndDate': estimatedEndDate,
//       'description': description,
//       'status': status,
//       'estimatedStartDate': estimatedStartDate,
//       'isAssigned': isAssigned,
//       'isActive': isActive,
//     };
//   }
// }
