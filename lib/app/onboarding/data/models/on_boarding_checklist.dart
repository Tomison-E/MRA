class OnBoardingChecklistModel {
  final String task;
  final bool isCompleted;
  final bool hasFocus;
  final String route;

  const OnBoardingChecklistModel(
      {required this.task,
      required this.isCompleted,
      required this.route,
      this.hasFocus = false,});
}
