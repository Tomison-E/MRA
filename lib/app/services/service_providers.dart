import 'package:mra/app/services/data/data_source/services_source.dart';
import 'package:mra/app/services/data/data_source/services_source_impl.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/data/repo_impl/services_repo_impl.dart';
import 'package:mra/app/services/domain/repo/services_repo.dart';
import 'package:mra/app/services/domain/use_cases/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesDataProvider = Provider<ServicesDataSource>((ref) {
  return ServicesDataSourceImplementation(ref);
});

final servicesRepoProvider = Provider<ServicesRepo>((ref) {
  return ServicesRepoImplementation(ref);
});

final servicesStateProvider = FutureProvider<List<ServiceStaff>>(
    (ref) async => (await ref.read(fetchArtisansUseCaseProvider)).extract());
