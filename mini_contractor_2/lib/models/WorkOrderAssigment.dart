// class WorkOrderAssigment {
//   final String contractorId;
//   final String requestStatus;
//   final String responseStatus;
//   final String workOrderId;

//   WorkOrderAssigment({
//     required this.contractorId,
//     required this.requestStatus,
//     required this.responseStatus,
//     required this.workOrderId, 
//   });

//   // Convert the object to a JSON representation
//   Map<String, dynamic> toJson() {
//     return {
//       'workOrderId': workOrderId,
//       'contractorId': contractorId,
//       'requestStatus': requestStatus,
//       'responseStatus': responseStatus,
//     };
//   }
// }

// class WorkOrderAssigments {
//   final String workOrderId;
//   final String contractorId;
//   final String requestStatus;
//   final String responseStatus;

//   WorkOrderAssigments({
//     required this.workOrderId,
//     required this.contractorId,
//     required this.requestStatus,
//     required this.responseStatus, 
//   });

//   // Convert the object to a JSON representation
//   Map<String, dynamic> toJson() {
//     return {
//       'workOrderId': workOrderId,
//       'contractorId': contractorId,
//       'requestStatus': requestStatus,
//       'responseStatus': responseStatus,
//     };
//   }
// }

// class WorkOrderAssignment {
//   final String contractorId;
//   final String requestStatus;
//   final String responseStatus;
//   final String workOrderId;

//   WorkOrderAssignment({
//     required this.contractorId,
//     required this.requestStatus,
//     required this.responseStatus,
//     required this.workOrderId,
//   });

//   // Convert the object to a JSON representation
//   Map<String, dynamic> toJson() {
//     return {
//       'workOrderId': workOrderId,
//       'contractorId': contractorId,
//       'requestStatus': requestStatus,
//       'responseStatus': responseStatus,
//     };
//   }
// }


class WorkOrderAssignment {
  final String contractorId;
  final String requestStatus;
  final String responseStatus;
  final String workOrderId;

  WorkOrderAssignment({
    required this.contractorId,
    required this.requestStatus,
    required this.responseStatus,
    required this.workOrderId,
  });

  // Convert the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'workOrderId': workOrderId,
      'contractorId': contractorId,
      'requestStatus': requestStatus,
      'responseStatus': responseStatus,
    };
  }
}
