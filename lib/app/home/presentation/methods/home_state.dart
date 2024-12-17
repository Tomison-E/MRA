import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/home/data/models/upcoming_item.dart';
import 'package:mra/app/onboarding/data/models/features.dart';
import 'package:mra/src/components/bottom_nav_icon.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

mixin HomeState {
  List<AppFeatureModel> getAppFeatures(UserType type) {
    switch (type) {
      case UserType.resident:
        return [
          AppFeatureModel(
            title: 'Access Control',
            description: 'Gain and grant access into the estate',
            showCaseText: 'You can let your guest into the estate from here',
            bgColor: kD9B8F3,
            borderColor: k82808C,
            action: (BuildContext ctx) => ctx.pushNamed(kAccessControlRoute),
          ),

          AppFeatureModel(
            title: 'Notice Board',
            description: 'Keep up with the activities in your estate',
            showCaseText: 'You can look up your estate activities here',
            bgColor: kEFF0F6,
            borderColor: kDDE5FF,
            action: (BuildContext ctx) => ctx.pushNamed(kNoticeBoardRoute),
          )
        ];
      case UserType.security:
        return [
          AppFeatureModel(
            title: 'Resident Verification',
            description: 'Verify guest to grant them access',
            showCaseText: 'You can verify residents of the estate',
            bgColor: k090322,
            borderColor: k82808C,
            action: (BuildContext ctx) =>
                ctx.pushNamed(kResidentVerificationRoute),
          ),
          AppFeatureModel(
            title: 'Guest Verification',
            description: 'Book artisans provided by your estate',
            showCaseText: 'You can book estate artisans from here',
            bgColor: k63B96A,
            borderColor: kBDFFC2,
            action: (BuildContext ctx) => ctx.pushNamed(kAccessControlRoute),
          ),
          AppFeatureModel(
            title: 'Alert Report',
            description: 'Respond to alerts by residents.',
            showCaseText: 'You can look up estate security reports here',
            bgColor: k3F4C75,
            borderColor: kDDE5FF,
            action: (BuildContext ctx) => ctx.pushNamed(kAlertRoute),
          ),
        ];
      default:
        return [];
    }
  }

  List<BottomNavigationBarItem> getAppBottomNavBar(UserType type) {
    switch (type) {
      case UserType.resident:
        return const [
          BottomNavigationBarItem(
              icon: Icon(BottomNavIcons.home),
              activeIcon: Icon(BottomNavIcons.homeActive),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(BottomNavIcons.payment),
              activeIcon: Icon(BottomNavIcons.paymentActive),
              label: 'Payments'),
          BottomNavigationBarItem(
              icon: Icon(BottomNavIcons.chat),
              activeIcon: Icon(BottomNavIcons.chatActive),
              label: 'Chat'),
        ];
      default:
        return [];
    }
  }

  List<UpcomingItemModel> getUpcomingItems(UserType type) {
    switch (type) {
      case UserType.resident:
        return const [
          UpcomingItemModel(
              type: UpcomingItemType.payment, title: 'Your light bill is due'),
          UpcomingItemModel(
              type: UpcomingItemType.payment,
              title: 'Your internet bill is due'),
          UpcomingItemModel(
              type: UpcomingItemType.approval,
              title: 'Generator Levy fee needs approval'),
        ];
      case UserType.security:
        return const [
          UpcomingItemModel(
              type: UpcomingItemType.alert,
              title: 'Alert report from the estate admin'),
          UpcomingItemModel(
              type: UpcomingItemType.alert,
              title: 'Alert report from the residents'),
        ];
      default:
        return [];
    }
  }
}
