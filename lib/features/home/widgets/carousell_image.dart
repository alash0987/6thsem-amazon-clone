import 'package:amazonclone/constants/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariable.carouselImages
            .map((i) => Builder(
                builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: 200,
                    )))
            .toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
          autoPlay: true,
        ));
  }
}
