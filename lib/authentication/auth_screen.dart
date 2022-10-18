import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_menu/authentication/login.dart';
import 'package:qr_menu/authentication/register.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'images/food_slider1.png',
  'images/food_slider2.png',
  'images/food_slider3.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
              )),
        ))
    .toList();

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _indicator = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.6,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _indicator = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
              items: imageSliders,
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _indicator == index ? const Color(0xff5800FF) : Colors.grey,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa là thành viên?',
                    style: GoogleFonts.firaSans(),
                  ),
                  TextButton(
                    child: Text(
                      'Đăng Ký Ngay!',
                      style: GoogleFonts.firaSans(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const RegisterScreen()));
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff5800FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5.0,
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Đăng Nhập',
                    style: GoogleFonts.firaSans(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const RegisterScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffDFF6FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5.0,
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Đăng Ký',
                    style:
                    GoogleFonts.firaSans(
                      fontSize: 20,
                      color: const Color(0xff5800FF),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
