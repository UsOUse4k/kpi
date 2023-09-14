import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.unexpected() = Unexpected;
  const factory Failure.badRequest(String message) = BadRequest;
  const factory Failure.serverError() = ServerError;
}
