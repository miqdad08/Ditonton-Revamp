import 'package:equatable/equatable.dart';

class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class ApiException extends Equatable implements Exception {
  const ApiException({
    this.message = "Terjadi Kesalahan",
    this.responseCode = false,
  });

  final String message;
  final bool responseCode;

  @override
  List<Object?> get props => [message, responseCode];
}
