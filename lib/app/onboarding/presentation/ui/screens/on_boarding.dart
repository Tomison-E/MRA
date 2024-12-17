import 'package:mra/app/onboarding/data/models/onboarding.dart';
import 'package:mra/app/onboarding/presentation/ui/widgets/on_boarding_card.dart';
import 'package:mra/app/onboarding/presentation/ui/widgets/on_boarding_page_indicator.dart';
import 'package:mra/core/services/storage/store.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OnBoardingScreen();
  }
}

class _OnBoardingScreen extends ConsumerState<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _slideController;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final _tween = Tween<Offset>(
    begin: const Offset(.0, .8),
    end: const Offset(.0, -.28),
  );

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = _tween.animate(_slideController);
    _slideController.forward();
    Store.saveOnBoardingInfo();
  }

  @override
  void dispose() {
    super.dispose();
    _slideController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF5F2FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: Column(
            children: [
              //PAGE INDICATOR
              OnBoardingPageIndicator(
                currentPage: _currentPage,
                totalPages: appOnBoardingModels.length,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: List.generate(
                    appOnBoardingModels.length,
                    (index) => OnBoardingCard(
                      currentPage: _currentPage,
                      animation: _animation,
                      index: index,
                      onBoardingModel: appOnBoardingModels[index],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 60.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context.goNamed(kLaunchRoute),
                      child: Text(
                        "Skip",
                        style: theme.textTheme.labelLarge
                            ?.copyWith(color: kGray3Color),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_currentPage < 2) {
                          _pageController.jumpToPage(_currentPage + 1);
                        } else {
                          context.goNamed(kLaunchRoute);
                        }
                      },
                      child: const Text("Next"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index != _currentPage) {
      setState(() {
        _currentPage = index;
      });
      _slideController.reset();
      _slideController.forward();
    }
  }
}

///models
const List<OnBoardingModel> appOnBoardingModels = [
  OnBoardingModel(
    title: 'Control Access',
    details: 'Grant and gain access easily into your estate\nwithout hassle',
    imagePath: kOnBoardOneImg,
  ),
  OnBoardingModel(
    title: 'Easy Payments',
    details: 'Manage and pay for your house and estate\nbills easily',
    imagePath: kOnBoardTwoImg,
  ),
  OnBoardingModel(
    title: 'Effortless communication',
    details: 'Chat with your estate admin and get replies\nwith ease',
    imagePath: kOnBoardThreeImg,
  ),
];
