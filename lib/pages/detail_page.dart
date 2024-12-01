import 'package:bootcamp_app/models/space.dart';
import 'package:bootcamp_app/pages/error_page.dart';
import 'package:bootcamp_app/widgets/facility_item.dart';
import 'package:bootcamp_app/widgets/rating_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class DetailPage extends StatefulWidget {
  final Space space;

  const DetailPage(this.space, {super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Future<void> launchUrl(String url) async {
      // Make launchUrl a Future
      final Uri uri = Uri.parse(url); // Parse the URL string into a Uri object
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri.toString());
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ErrorPage()),
        );
      }
    }

    Future<void> handleBook(Space space) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Konfirmasi'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah kamu ingin menghubungi pemilik kos?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Nanti', style: greyTextStyle),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Hubungi'),
                onPressed: () {
                  Navigator.of(context).pop();
                  launchUrl('tel:${space.phone}');
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              widget.space.imageUrl!, // Add null check
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                const SizedBox(height: 328),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.space.name!, // Add null check
                                  style: blackTextStyle.copyWith(fontSize: 22),
                                ),
                                const SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        '\$${widget.space.price}', // Add null check
                                    style:
                                        purpleTextStyle.copyWith(fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: ' / month',
                                        style: greyTextStyle.copyWith(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [1, 2, 3, 4, 5].map((index) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: RatingItem(
                                    index: index,
                                    rating:
                                        widget.space.rating!, // Add null check
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Main Facilities',
                            style: regularTextStyle.copyWith(fontSize: 16)),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(
                              name: 'kitchen',
                              imageUrl: 'assets/icon_kitchen.png',
                              total: widget
                                  .space.numberOfKitchens!, // Add null check
                            ),
                            FacilityItem(
                              name: 'bedroom',
                              imageUrl: 'assets/icon_bedroom.png',
                              total: widget
                                  .space.numberOfBedrooms!, // Add null check
                            ),
                            FacilityItem(
                              name: 'Big Lemari',
                              imageUrl: 'assets/icon_cupboard.png',
                              total: widget
                                  .space.numberOfCupboards!, // Add null check
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Photos',
                            style: regularTextStyle.copyWith(fontSize: 16)),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 88,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.space.photos!.map((item) {
                            // Add null check
                            return Container(
                              margin: const EdgeInsets.only(left: 24),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item,
                                  width: 110,
                                  height: 88,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text('Location',
                            style: regularTextStyle.copyWith(fontSize: 16)),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.space.address}\n${widget.space.city}',
                              style: greyTextStyle,
                            ),
                            InkWell(
                              onTap: () => launchUrl(widget.space
                                  .mapUrl!), // Add null check and use launchUrl
                              child: Image.asset(
                                'assets/btn_map.png',
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: edge),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: ElevatedButton(
                          // Use ElevatedButton
                          onPressed: () => handleBook(widget.space),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: purpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                          child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/btn_back.png', width: 40),
                  ),
                  InkWell(
                    onTap: () => setState(() => isFavorite = !isFavorite),
                    child: Image.asset(
                      isFavorite
                          ? 'assets/btn_wishlist_active.png'
                          : 'assets/btn_wishlist.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
