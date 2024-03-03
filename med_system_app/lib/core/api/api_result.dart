import 'package:distrito_medico/core/api/network_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = _Success;
  const factory Result.failure(NetworkExceptions error) = _Failure;
}
