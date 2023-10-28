import 'package:taskplus/Theme/Animation/animation_plate.dart';

class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List contents = [
  OnboardingContent(
    title: 'Welcome to TaskPlus',
    image: Motion.BORDING1,
    discription:
        "TaskPlus is here to simplify your daily routine. With powerful features and a user-friendly interface, you can now manage your tasks effortlessly. Let's get started!",
  ),
  OnboardingContent(
      title: 'Features That Make a Difference',
      image: Motion.BORDING2,
      discription:
          "TaskPlus offers a range of features designed to help you stay organized:Create tasks and to-do lists with ease. Set due dates and reminders, never miss an important deadline.Prioritize tasks using categories and labels. Sync your tasks across all your devices."),
  OnboardingContent(
      title: 'Manage Your Life with TaskPlus',
      image: Motion.BORDING3,
      // image: Motion.BORDING3,

      discription:
          " TaskPlus is more than just a to-do app; it's your partner in managing life's demands. With TaskPlus, you can take control of your schedule, boost productivity, and achieve your goals."
          " Let's start organizing your life together! Feel free to use this simplified onboarding content for your app. You can further customize it to match the design and branding of your TaskPlus To-Do app."),
];
