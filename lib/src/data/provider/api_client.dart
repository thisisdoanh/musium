import 'dart:convert';
import 'dart:io' as io;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../util/dio_logger/dio_logger.dart';
import '../model/base_response.dart';

class ApiClient {
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String DELETE = 'DELETE';
  static const String PATCH = 'PATCH';
  static const String PUT = 'PUT';

  static const CONTENT_TYPE = 'Content-Type';
  static const CONTENT_TYPE_JSON = 'application/json; charset=utf-8';

  static final BaseOptions defaultOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    responseType: ResponseType.plain,
    headers: {
      'Cache-Control': 'no-cache',
      'Content-Type': 'application/json; charset=utf-8'
      // "X-RapidAPI-Key": "f7a518daf4msh3c184e00980affap197ee7jsn44dfe3ac6589",
      // "X-RapidAPI-Host": "spotify23.p.rapidapi.com",
    },
  );

  Dio? _dio;

  static final Map<BaseOptions, ApiClient> _instanceMap = {};

  factory ApiClient({BaseOptions? options}) {
    options ??= defaultOptions;

    if (_instanceMap.containsKey(options)) {
      return _instanceMap[options] ?? ApiClient._create(options: options);
    }

    final ApiClient apiClient = ApiClient._create(options: options);
    _instanceMap[options] = apiClient;
    return apiClient;
  }

  ApiClient._create({BaseOptions? options}) {
    options ??= defaultOptions;
    _dio = Dio(options);
    _dio?.interceptors.add(
      DioLogger(
        settings: const DioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );
  }

  static ApiClient get instance => ApiClient();

  Future<BaseResponse> request<T extends BaseResponseData>({
    String endPoint = '',
    String method = POST,
    String? data,
    Function? fromJsonModel,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParameters,
    bool getFullResponse = false,
    bool isJson = true,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return BaseResponse(
        result: false,
        data: null,
        message: "no internet",
        code: 2106,
      );
    }
    if (endPoint.isEmpty) {
      return BaseResponse(
        result: false,
        data: null,
        message: 'Empty endPoint.',
        code: -1111,
      );
    }
    try {
      (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        io.HttpClient client = io.HttpClient();

        client.badCertificateCallback =
            (io.X509Certificate cert, String host, int port) {
          return true;
        };

        return client;
      };
      final response = await _dio?.request(endPoint,
          data: formData != null
              ? FormData.fromMap(formData)
              : data ?? jsonEncode({}),
          options: Options(
              method: method,
              contentType: formData != null ? 'multipart/form-data' : null),
          queryParameters: queryParameters);
      if (_isSuccessful(response?.statusCode ?? -1)) {
        if (isJson) {
          dynamic responseData = json.decode(response?.data ?? '');
          Map<String, dynamic> dataOut = {
            'code': 1000,
            'data': responseData,
            'rawData': response?.data,
            'message': '',
            'result': true,
          };
          var apiResponse = BaseResponse<T>.fromJson(dataOut, fromJsonModel);
          if (getFullResponse) apiResponse.dioResponse = response;
          return apiResponse;
        } else {
          Map<String, dynamic> dataOut = {
            'code': 1000,
            'data': response?.data,
            'rawData': response?.data,
            'message': '',
            'result': true,
          };
          var apiResponse = BaseResponse<T>.fromJson(dataOut, fromJsonModel);
          if (getFullResponse) apiResponse.dioResponse = response;
          return apiResponse;
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
// e.response.data có thể trả về _InternalLinkedHashMap hoặc 1 kiểu nào đó (String), tạm thời check thủ công theo runtimeType
        String errorMessage = e.response?.data != null &&
                (e.response?.data.runtimeType ?? '')
                    .toString()
                    .contains('Map') &&
                (e.response?.data['message'] ?? '').toString().isNotEmpty
            ? e.response?.data['message']
            : (e.response?.statusMessage ?? '').toString().isNotEmpty
                ? e.response?.statusMessage
                : e.message;
        return BaseResponse(
          result: false,
          data: null,
          message: errorMessage,
          code: e.response?.statusCode,
        );
      }
      if (e.error is io.SocketException) {
        io.SocketException socketException = e.error as io.SocketException;

        return BaseResponse(
          result: false,
          data: null,
          message: socketException.osError?.message ?? "",
          code: socketException.osError?.errorCode ?? 0,
        );
      }
      return BaseResponse(
        result: false,
        data: null,
        message: e.error != null ? e.error.toString() : "",
        code: -9999,
      );
    }
    return BaseResponse(
      result: false,
      data: null,
      message: 'Unknown error',
      code: -8888,
    );
  }

  bool _isSuccessful(int i) {
    return i >= 200 && i <= 299;
  }
}
