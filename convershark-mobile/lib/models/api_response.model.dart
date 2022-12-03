class BodyResponse {
  final String message;

  const BodyResponse({required this.message});

  factory BodyResponse.fromJson(Map<String, dynamic> json) {
    return BodyResponse(
      message: json['message'],
    );
  }
}

class ApiResponse {
  final bool isSuccess;
  final BodyResponse payload;

  const ApiResponse({
    required this.isSuccess,
    required this.payload,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: json['success'],
      payload: BodyResponse.fromJson(json['payload']),
    );
  }
}
