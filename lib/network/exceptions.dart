import 'package:meta/meta.dart';

abstract class MyException implements Exception {
  final message = 'An Error Occurred, Try Again';
}

class EmptyResultException extends MyException {
  final message = 'Error, Empty Response, Try Again';
}

class ConnectionException extends MyException {
  final message = 'Network Connection Error, Try Again';
}

class ServerErrorException extends MyException {
  final message = 'Server Error, Try Again';
}

class ClientErrorException extends MyException {}

class AuthenticationException extends MyException {
  final message = 'Error, Your Request Is Not Authenticated. Login';
}

class ValidationErrorException extends MyException {
  final message = 'Validation Error, Check Input';
  final Map<String, dynamic> errors;
  ValidationErrorException({required this.errors});
}

class UnknownException extends MyException {
  UnknownException({this.message = 'Unknown Error Occurred!'});
  final String message;
}
