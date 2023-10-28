// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/features/Post/Card_content.dart';
import 'package:taskplus/features/Post/Services/Poster_Services.dart';
import 'package:taskplus/features/Post/Widget/Custom_Slider_Card.dart';

class TodoSliderScreenView extends ConsumerWidget {
  const TodoSliderScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchPoster = ref.watch(fetchPostData);

    bool shouldAutoPlay = fetchPoster.value != null &&
        fetchPoster.value!.isNotEmpty &&
        fetchPoster.value!.length > 1;

    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.32,
          child: CarouselSlider.builder(
            itemCount: fetchPoster.value == null || fetchPoster.value!.isEmpty
                ? cardContents.length
                : fetchPoster.value!.length,
            itemBuilder: (context, index, realIndex) {
              if (fetchPoster.value == null || fetchPoster.value!.isEmpty) {
                return CustomePosterCard(
                  image: cardContents[index % cardContents.length].image,
                  quot: cardContents[index % cardContents.length].quot,
                  auther: cardContents[index % cardContents.length].auther,
                );
              } else {
                return CustomePosterCard(
                  image: fetchPoster.value![index].image,
                  quot: fetchPoster.value![index].quote,
                  auther: fetchPoster.value![index].author,
                );
              }
            },
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: shouldAutoPlay,
              enlargeCenterPage: true,
              disableCenter: true,
            ),
          ),
        ),
      ],
    );
  }
}
