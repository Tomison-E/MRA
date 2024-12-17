import 'package:mra/app/services/data/models/service_staff.dart';

abstract class ServicesDataSource {
  Future<List<ServiceStaff>> getArtisans(String estateId);
}
