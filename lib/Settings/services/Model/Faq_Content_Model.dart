class FaqContent {
  final String question;
  final String answers;

  FaqContent({
    required this.question,
    required this.answers,
  });
}

List faqContent = [
  FaqContent(
      question: '1. What is TaskPlus?',
      answers:
          '\t\t\tTaskPlus is an advanced Android application designed for efficient time and task management. It offers a range of features for organizing tasks, setting reminders, and visualizing schedules.'),
  FaqContent(
      question: '2. How can I add tasks in TaskPlus?',
      answers:
          '\t\t\tTo add tasks, simply navigate to the app and use the "Add Task" feature. Input the task details, including repetition, notification alerts, and the start and end times as needed.'),
  FaqContent(
      question: '3. Does TaskPlus provide a calendar view for tasks?',
      answers:
          '\t\t\tYes, TaskPlus offers a calendar feature that allows users to visualize their scheduled tasks for a better understanding of their task timelines.'),
  FaqContent(
      question: '4. Is there a user authentication feature in TaskPlus?',
      answers:
          '\t\t\tYes, TaskPlus prioritizes user data security and offers user authentication to ensure privacy and personalized task lists for each user.'),
  FaqContent(
      question: '5. Can I add sticky notes in TaskPlus?',
      answers:
          '\t\t\tAbsolutely. TaskPlus includes a unique feature that enables users to add sticky notes, offering a convenient way to jot down quick notes or reminders associated with tasks.'),
  FaqContent(
      question: '6. Does TaskPlus support a dark mode?',
      answers:
          '\t\t\tYes, TaskPlus provides a dark mode feature, making the app visually comfortable, especially in low-light conditions.'),
  FaqContent(
      question: '7. Is the user interface (UI) user-friendly in TaskMaster?',
      answers:
          '\t\t\tCertainly. TaskMaster boasts a user-centric UI designed for a smooth and visually appealing experience, ensuring ease of use for the users.')
];
