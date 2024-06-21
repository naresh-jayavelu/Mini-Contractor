// Define your model class
class WorkOrderAssignment {
  final String workOrderAssignmentId;
  final WorkOrder workOrderId;
  final String requestStatus;
  final String responseStatus;
  final String contractorId;

  WorkOrderAssignment({
    required this.workOrderAssignmentId,
    required this.workOrderId,
    required this.requestStatus,
    required this.responseStatus,
    required this.contractorId,
  });

  factory WorkOrderAssignment.fromJson(Map<String, dynamic> json) {
    return WorkOrderAssignment(
      workOrderAssignmentId: json['workOrderAssigmentId'],
      workOrderId: WorkOrder.fromJson(json['workOrderId']),
      requestStatus: json['requestStatus'],
      responseStatus: json['responseStatus'],
      contractorId: json['contractorId'],
    );
  }
}

class WorkOrder {
  final String id;
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
    required this.id,
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
      id: json['Id'],
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
