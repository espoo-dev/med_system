import 'dart:convert';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:med_system_app/core/api/error.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    ErrorModelResponse? errorModel;

    try {
      errorModel = ErrorModelResponse.fromJson(
          json.decode(response?.error.toString() ?? ''));
    } catch (e) {
      rethrow;
    }

    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(
            errorModel.message ?? "Not found");

      case 404:
        return NetworkExceptions.notFound(errorModel.message ?? "Not found");

      case 409:
        return const NetworkExceptions.conflict();

      case 408:
        return const NetworkExceptions.requestTimeout();

      case 500:
        return const NetworkExceptions.internalServerError();

      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        var responseCode = statusCode;
        return NetworkExceptions.defaultError(
          "Received invalid status code: $responseCode",
        );
    }
  }

  static NetworkExceptions getException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Não implementado";
    }, requestCancelled: () {
      errorMessage = "Solicitação cancelada";
    }, internalServerError: () {
      errorMessage = "Erro do Servidor Interno";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Serviço não disponível";
    }, methodNotAllowed: () {
      errorMessage = "Método não permitido";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorizedRequest: (String error) {
      errorMessage = error;
    }, unexpectedError: () {
      errorMessage = "Ocorreu um erro inesperado";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout";
    }, noInternetConnection: () {
      errorMessage = "Sem conexão com a internet";
    }, conflict: () {
      errorMessage = "Erro devido a um conflito";
    }, sendTimeout: () {
      errorMessage = "Enviar tempo limite em conexão com o servidor de API";
    }, unableToProcess: () {
      errorMessage = "Não foi possível processar os dados";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Ocorreu um erro inesperado";
    }, notAcceptable: () {
      errorMessage = "Não aceitável";
    });
    return errorMessage;
  }
}
