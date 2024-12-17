import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/service_providers.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchArtisansUseCaseProvider =
    AutoDisposeProvider<Future<ApiResult<List<ServiceStaff>>>>(
  (ref) => UseCase<List<ServiceStaff>>().call(() => ref
      .read(servicesRepoProvider)
      .getArtisans(ref.read(userStateProvider)!.estate.id)),
);
