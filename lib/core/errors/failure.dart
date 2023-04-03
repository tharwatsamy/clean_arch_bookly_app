import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioError e) {
    switch (e.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');

      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioErrorType.badCertificate:
        return ServerFailure('badCertificate with api server');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioErrorType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioErrorType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else {
      return ServerFailure('There was an error , please try again');
    }
  }
}
