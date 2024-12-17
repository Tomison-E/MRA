import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home/presentation/methods/home_state.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppShell extends ConsumerStatefulWidget {
  final Widget child;

  const AppShell(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppShell();
  }
}

class _AppShell extends ConsumerState<AppShell> with HomeState {
  late final navigation = getAppBottomNavBar(ref.read(userStateProvider)!.role);

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).routeInformationProvider.value.uri.path);

  int _locationToTabIndex(String location) {
    final index = navigation
        .indexWhere((t) => location.startsWith("/${t.label!.toLowerCase()}"));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onTabTapped(int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.goNamed(navigation[tabIndex].label!.toLowerCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      bottomNavigationBar: navigation.isNotEmpty
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              items: navigation,
              iconSize: 45.h,
              onTap: (index) => _onTabTapped(index),
            )
          : null,
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}
