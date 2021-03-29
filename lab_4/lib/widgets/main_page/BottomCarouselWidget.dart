import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_4/util/percentage_sizes.dart';
import 'package:lab_4/widgets/details_page/DetailsPage.dart';

final List<String> bottomImages = [
  'https://media.beaut.ie/uploads/2017/06/23101144/mango-wool-red-coat.jpg',
  'https://assets.ajio.com/medias/sys_master/root/20210106/Wfyt/5ff57daaf997dd5c40cc691d/-1117Wx1400H-461033961-blue-MODEL.jpg',
  'https://img.faballey.com/Images/Product/JAC00438Z/d3.jpg',
  'https://assets.ajio.com/medias/sys_master/root/he4/h5e/13752145248286/-1117Wx1400H-440990330-mustard-MODEL.jpg',
];

List<Widget> bottomSlides(BuildContext context) {
  return bottomImages.map((item) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return DetailsPage(item);
        }),
      );
    },
    child: Container(
        width: getWidth(context, 0.3),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              alignment: FractionalOffset.topCenter,
              image: NetworkImage(item),
            )
        )
    ),
  )).toList();
}


class BottomCarouselWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context, 0.2),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: bottomSlides(context),
      ),
    );
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     height: getHeight(context, 0.2),
    //     aspectRatio: 2,
    //     viewportFraction: 0.33,
    //     initialPage: 1,
    //     enableInfiniteScroll: false,
    //     reverse: false,
    //     autoPlay: false,
    //     enlargeCenterPage: false,
    //     scrollDirection: Axis.horizontal,
    //   ),
    //   items: bottomSlides,
    // );
  }

}