import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_4/util/percentage_sizes.dart';
import 'package:lab_4/values/colors.dart';
import 'package:lab_4/values/dimens.dart';
import 'package:lab_4/values/styles.dart';

final List<String> imgList = [
  'https://www.whistles.com/dw/image/v2/BDCH_PRD/on/demandware.static/-/Sites-whistles-master-catalog/default/dw7785f745/images/00103024627/whistles-alexandra-belted-coat-dark-green-01.jpg?sw=1429&sh=2000&strip=false',
  'https://www.whistles.com/dw/image/v2/BDCH_PRD/on/demandware.static/-/Sites-whistles-master-catalog/default/dw0a7855b0/images/00103024627/whistles-alexandra-belted-coat-dark-green-02.jpg?sw=1429&sh=2000&strip=false',
  'https://www.whistles.com/dw/image/v2/BDCH_PRD/on/demandware.static/-/Sites-whistles-master-catalog/default/dwd305d41f/images/00103024627/whistles-alexandra-belted-coat-dark-green-03.jpg?sw=1429&sh=2000&strip=false',
  'https://www.whistles.com/dw/image/v2/BDCH_PRD/on/demandware.static/-/Sites-whistles-master-catalog/default/dwf077f6e8/images/00103024627/whistles-alexandra-belted-coat-dark-green-99.jpg?sw=1429&sh=2000&strip=false',
];

final List<Widget> imageSliders = imgList.map((item) => Container(
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.topCenter,
          image: NetworkImage(item),
        )
    )
)).toList();

class MainCarouselStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainCarouselWidgetState();

}

class MainCarouselWidgetState extends State<MainCarouselStatefulWidget> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          )
          ]),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: getHeight(context, 0.5),
              aspectRatio: 5/4,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imageSliders,
          ),
          Positioned(
            bottom: 0,
            child: Container(
                height: getHeight(context, 0.1),
                width: 1000,
                color: mainColor.withOpacity(0.7),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NEW LOOK TAILORED COAT",
                        style: mainTextStyle(Colors.white, FontWeight.w500),
                      ),
                      Row(
                        children: imgList.map((url) {
                          int index = imgList.indexOf(url);
                          return Container(
                            width: 5.0,
                            height: 5.0,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}


