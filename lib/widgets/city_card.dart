import 'package:bootcamp_app/models/city.dart';
import 'package:bootcamp_app/theme.dart';
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final City city;

  const CityCard(this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 150,
        width: 120,
        color: const Color(0xffF6F7F8),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 102,
                  child: Image.asset(
                    city.imageUrl,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                if (city.isPopular)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icon_star.png',
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 11),
            Text(
              city.name,
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
