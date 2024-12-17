import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class ServicesRepo {
  Future<ApiResult<List<ServiceStaff>>> getArtisans(String estateId);
}
