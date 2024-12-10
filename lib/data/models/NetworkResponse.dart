class NetworkResponse {
  bool isError;
  Object? response;
  String responseMessage;

  NetworkResponse._internal(
      {required this.isError,
      required this.response,
      required this.responseMessage});

  factory NetworkResponse.success(
      {Object? response, required String responseMessage}) {
    return NetworkResponse._internal(
        isError: false, response: response, responseMessage: responseMessage);
  }

  factory NetworkResponse.error(
      {Object? response, required String responseMessage}) {
    return NetworkResponse._internal(
        isError: true, response: response, responseMessage: responseMessage);
  }

  @override
  String toString() {
    return 'NetworkResponse{isError: $isError, response: $response, responseMessage: $responseMessage}';
  }
}
