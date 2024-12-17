import 'package:mra/app/services/data/data_source/services_source.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String artisans = "artisans";

class ServicesDataSourceImplementation extends ServicesDataSource {
  final Ref _ref;

  ServicesDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<List<ServiceStaff>> getArtisans(String estateId) async {
    final response = await _apiClient.get("$kEstateRoute/$estateId/$artisans");
    return (response.data["data"] as List<dynamic>)
        .map((e) => ServiceStaff.fromJson(e))
        .toList();
  }
}
