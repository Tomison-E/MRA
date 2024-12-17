import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/core/config/api_config/api_config.dart';
import 'package:mra/core/config/app_config/app_config.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/dev.env.dart'
    if (kFlavorEnv == "prod") 'package:mra/prod.env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appConfigProvider = Provider<AppConfig>((_) {
  return AppConfig.fromJson(appConfig);
});

final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig(ref.read(appConfigProvider).baseUrl,
      bearerToken: () => ref.read(sessionProvider).accessToken);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.read(apiConfigProvider);
  return ApiClient(config);
});

/*final storeProvider = Provider(
  (ref) async{
    final prefs = await SharedPreferences.getInstance();
    return Storage(prefs);
  },
);*/

typedef UseCaseFunc<T> = Future<ApiResult<T>> Function();

class UseCase<T> {
  Future<ApiResult<T>> call(UseCaseFunc<T> function) async => await function();

  Future<T> init(UseCaseFunc<T> function) async => (await function()).extract();
}
