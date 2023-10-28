import 'package:taskplus/Theme/Images/Image_plate.dart';

class CardContent {
  String image;
  String quot;
  String auther;

  CardContent({
    required this.image,
    required this.quot,
    required this.auther,
  });
}

List cardContents = [
  CardContent(
      quot:
          'We are what we repeatedly do. Excellence, therefore is not on oct but a habit. ',
      auther: 'Astrolite',
      image: ImagesProvider.GURU_IMAGE),
  CardContent(
      quot:
          'Until you value yourself, you will not value your time. Until you value your time, you will not do anything with it',
      auther: 'M. Scott Peck',
      image: ImagesProvider.GURU_IMAGE)
];
