import 'package:mra/app/services/data/data_source/services_source.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/domain/repo/services_repo.dart';
import 'package:mra/app/services/service_providers.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServicesRepoImplementation extends ServicesRepo {
  final Ref _ref;

  ServicesRepoImplementation(this._ref);

  late final ServicesDataSource _dataSource = _ref.read(servicesDataProvider);

  @override
  Future<ApiResult<List<ServiceStaff>>> getArtisans(String estateId) {
    return dioInterceptor(() => _dataSource.getArtisans(estateId));
  }
}
