import 'package:connectinno_task/core/services/network_handler/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORISED,
  FORBIDDEN,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  UNKNOWN,
  NO_INTERNET_CONNECTION,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
          ResponseCode.INTERNAL_SERVER_ERROR,
          ResponseMessage.INTERNAL_SERVER_ERROR,
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
          ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION,
        );
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400; // invalid request
  static const int UNAUTHORISED = 401; // unauthorized
  static const int FORBIDDEN = 403; // forbidden
  static const int NOT_FOUND = 404; // not found
  static const int INTERNAL_SERVER_ERROR = 500; // server crash

  // Local status codes
  static const int UNKNOWN = -1;
  static const int NO_INTERNET_CONNECTION = -2;
}

class ResponseMessage {
  static const String SUCCESS = "Success"; // 200
  static const String NO_CONTENT = "Success "; // 201
  static const String BAD_REQUEST = "Bad request, invalid parameters"; // 400
  static const String UNAUTHORISED = "Unauthorized, please login again"; // 401
  static const String FORBIDDEN = "Forbidden request"; // 403
  static const String NOT_FOUND = "Resource not found"; // 404
  static const String INTERNAL_SERVER_ERROR = "Internal server error"; // 500

  // Local status messages
  static const String UNKNOWN = "Unknown error occurred";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}
