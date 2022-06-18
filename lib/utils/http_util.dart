import 'package:dio/dio.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';
import 'package:sail_app/utils/common_util.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';

class HttpUtil {
  // 工厂模式
  static HttpUtil get instance => _getInstance();
  static HttpUtil _httpUtil;
  Dio dio;

  static HttpUtil _getInstance() {
    _httpUtil ??= HttpUtil();
    return _httpUtil;
  }

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      print("========================request data===================");
      print("url=${options.uri.toString()}");
      print("headers=${options.headers}");
      print("params=${options.data}");

      //如果token存在在请求参数加上token
      await SharedPreferencesUtil.getInstance().getString(AppStrings.token).then((token) {
        if (token != null) {
          options.queryParameters[AppStrings.token] = token;
          print("token=$token");
        }
      });

      //如果auth_data存在在请求参数加上auth_data
      await SharedPreferencesUtil.getInstance().getString(AppStrings.authData).then((authData) {
        if (authData != null) {
          options.queryParameters[AppStrings.authData] = authData;
          print("authData=$authData");
        }
      });

      return handler.next(options);
    }, onResponse: (response, handler) {
      print("========================request data===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");

      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (response.statusCode == 403) {
          Application.navigatorKey.currentState.pushNamed(Routers.login);
        }

        return handler
            .reject(DioError(requestOptions: response.requestOptions, response: response, type: DioErrorType.response));
      }

      return handler.next(response);
    }, onError: (error, handler) {
      print("========================request error===================");
      print("message =${error.message}");
      print("code=${error.response?.statusCode}");
      print("response=${error.response?.data}");

      return handler.next(error);
    }));
  }

  //get请求
  Future get(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  //post请求
  Future post(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response.data;
  }

  //put请求
  Future put(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.put(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.put(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.put(url, options: options);
    } else {
      response = await dio.put(url);
    }
    return response.data;
  }

  //delete请求
  Future delete(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.delete(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.delete(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.delete(url, options: options);
    } else {
      response = await dio.delete(url);
    }
    return response.data;
  }
}
