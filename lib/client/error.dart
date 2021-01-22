// @dart=2.0

part of influxdb_client_api;

class InfluxDBException implements Exception {
  int statusCode;
  String code;
  String message;

  InfluxDBException(this.statusCode, this.code, this.message);

  static InfluxDBException fromResponse(Response response) {
    return fromJson(response.body, response.statusCode);
  }

  static InfluxDBException fromJson(String errorBody, int statusCode) {
    String code;
    String message;
    dynamic body;
    try {
      body = json.decode(errorBody);
    } catch (e) {
      message = errorBody;
    }
    if (body != null) {
      if (body['message'] != null) {
        message = body['message'].toString();
      }
      if (body['code'] != null) {
        code = body['code'].toString();
      }
    }
    return InfluxDBException(statusCode, code, message);
  }

  @override
  String toString() {
    return 'InfluxDBException: statusCode = $statusCode, code = $code, message = $message';
  }

}
