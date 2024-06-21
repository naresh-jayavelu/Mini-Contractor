import 'dart:convert';

class Review {
  String entityType;
  String entityId;
  String workOrderId;
  String rating;
  String comment;

  Review({
    required this.entityType,
    required this.entityId,
    required this.workOrderId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'entityType': entityType,
      'entityId': entityId,
      'workOrderId': workOrderId,
      'rating': rating,
      'comment': comment,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      entityType: json['entityType'],
      entityId: json['entityId'],
      workOrderId: json['workOrderId'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}
