import 'package:mra/app/services/data/models/service_staff.dart';

class EstateService {
  final String name;
  final String iconPath;
  final ServiceType type;
  final bool isAvailable;

  const EstateService(
      {required this.name,
      required this.iconPath,
      required this.type,
      this.isAvailable = false});
}
