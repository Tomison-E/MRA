import 'package:mra/app/services/data/models/estate_service.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/presentation/ui/widgets/service_tile.dart';
import 'package:mra/app/services/service_providers.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesState = ref.watch(servicesStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: servicesState.when(
          data: (services) {
            return ListView(
              children: _services
                  .map(
                    (e) => ServiceTile(
                      service: e,
                      artisans: services
                          .where((element) => element.type == e.type)
                          .toList(),
                    ),
                  )
                  .toList(),
            );
          },
          error: (error, __) => ErrorState(error:error),
          loading: () => const LoadingState(),
        ),
      ),
    );
  }
}

List<EstateService> _services = const [
  EstateService(
      name: 'A/C Repairs', type: ServiceType.ac, iconPath: kACRepairSvg),
  EstateService(
      name: 'Plumbing', type: ServiceType.plumbing, iconPath: kPlumbingSvg),
  EstateService(
      name: 'Carpentry', type: ServiceType.carpentry, iconPath: kCarpentrySvg),
];
