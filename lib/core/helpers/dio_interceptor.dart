import 'package:mra/core/service_exceptions/src/api_exceptions.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef TypeDef = Function();

Future<ApiResult<T>> dioInterceptor<T>(TypeDef func) async {
  try {
    final result = await func();
    return ApiResult.success(data: result);
  } on DioException catch (exception) {
    return ApiResult.apiFailure(
            error: ApiExceptions.getDioException(exception)!,
            statusCode: exception.response?.statusCode ?? -1);
  } on Error catch (e) {
    debugPrint(e.stackTrace.toString());
    return ApiResult.apiFailure(
        error: ApiExceptions.getDioException(e)!, statusCode: -1);
  } catch (e) {
    debugPrint(e.toString());
    return ApiResult.apiFailure(
        error: ApiExceptions.getDioException(e)!, statusCode: -1);
  }
}
