import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

final List<Widget> imageSliders = imgList.asMap().entries.map((entry) {
  int index = entry.key;
  String imageUrl = entry.value;

  return Container(
    margin: const EdgeInsets.all(5.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network(imageUrl, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                imgText[index], // Используем индекс для соответствующего текста
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}).toList();

final List<String> imgList = [
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/435800053_453539817099492_4264187699336083388_n.jpg?stp=c0.420.1080.1080a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=100&_nc_ohc=hvwMYp_miu4Q7kNvgGv6TCS&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYBXRGOZKEJHgDTpbZpl0W54WuLmo2syUCb4Of7YSsNkSQ&oe=673661E4&_nc_sid=8b3546',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/434365489_1393211641312185_2192624469132396031_n.jpg?stp=c0.882.2268.2268a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=109&_nc_ohc=anjwe7_ury4Q7kNvgEIMjal&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYCKJ3zgJ6BeMduwl8YuRsc47tS2DuJZSZouFFyakJfS5A&oe=673662CD&_nc_sid=8b3546',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/339947061_1314227339134055_578147237799846667_n.jpg?stp=c0.133.1066.1066a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=8e-PmPj343MQ7kNvgFauNwU&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYDRu7f3X_YwPh9xRH79FAWBw0pNZe8cx1LqCGjTIVlIKw&oe=67366574&_nc_sid=8b3546',
  'https://instagram.ftse3-2.fna.fbcdn.net/v/t51.29350-15/458515791_538528958553596_6629807119048189200_n.jpg?stp=c0.180.1440.1440a_dst-jpg_e35_s640x640_sh0.08&_nc_ht=instagram.ftse3-2.fna.fbcdn.net&_nc_cat=108&_nc_ohc=kJKg5Ll_5-oQ7kNvgFdJtIB&_nc_gid=b363e146586d46eeae659025f1db6da3&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AYAZwU8Lh15n9RPNbtosZFTUm5ThYAIdYsziWtknQ2u95g&oe=67365413&_nc_sid=8b3546',
  'https://avatars.mds.yandex.net/get-altay/7021598/2a000001877293dbd075786e4cf27af18f40/L',
  'https://avatars.mds.yandex.net/get-altay/11492238/2a0000018e1a112082e87bb8aca903ba1838/h220'
];
final List<String> imgText = [
  'Barbershop Arys',
  'Best barber\'s',
  'Say promocode to barber',
  'Check new haircut\'s!',
  'Street:Егемен Казахстан,46',
  'Test our best service',
];
