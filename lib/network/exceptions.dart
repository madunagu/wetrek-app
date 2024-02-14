
abstract class MyException implements Exception {
  @override
  String toString() => 'An Error Occurred, Try Again';
}

class EmptyResultException extends MyException {
  @override
  String toString() => 'Error, Empty Response, Try Again';
}

class ConnectionException extends MyException {
  @override
  String toString() => 'Network Connection Error, Try Again';
}

class ServerErrorException extends MyException {
  @override
  String toString() => 'Server Error, Try Again';
}

class ClientErrorException extends MyException {}

class AuthenticationException extends MyException {
  @override
  String toString() => 'Error, Your Request Is Not Authenticated. Login';
}

class ValidationErrorException extends MyException {
  @override
  String toString() => 'Validation Error, Check Input';
  final Map<String, dynamic> errors;
  ValidationErrorException({required this.errors});
}

class UnknownException extends MyException {
  UnknownException({this.message = 'Unknown Error Occurred!'});
  final String message;
  @override
  String toString() => message;
}
