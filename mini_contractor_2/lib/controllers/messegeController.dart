class APIResponse {
  bool success;
  dynamic data;

  APIResponse(this.success, this.data);

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      json['success'] as bool,
      json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
    };
  }
}
