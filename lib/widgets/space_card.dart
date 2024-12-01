import 'package:bootcamp_app/models/space.dart';
import 'package:bootcamp_app/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SpaceCard extends StatelessWidget {
  final Space space;

  const SpaceCard(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(space),
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(
                    // Use Image.network for URLs
                    space.imageUrl ?? '', // Handle potential null value
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon_star.png',
                            width: 22,
                            height: 22,
                          ),
                          Text(
                            '${space.rating ?? 0}/5', // Handle potential null value
                            style: whiteTextStyle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                space.name ?? '', // Handle potential null value
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text.rich(
                TextSpan(
                  text: '\$${space.price ?? 0}', // Handle potential null value
                  style: purpleTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' / month',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '${space.city ?? ''}, ${space.country ?? ''}', // Handle potential null values
                style: greyTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
