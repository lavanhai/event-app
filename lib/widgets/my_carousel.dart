import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List dataSlider = [1,2,3,4,5];
    return CarouselSlider(
      options: CarouselOptions(height: 200,autoPlay: true),
      items: dataSlider.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child: Image.network("https://www.eventbookings.com/wp-content/uploads/2024/01/Different-Types-of-Events-in-2024-Which-is-Right-for-You.jpg")),
            );
          },
        );
      }).toList(),
    );
  }
}
