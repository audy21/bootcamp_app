import 'package:bootcamp_app/models/city.dart';
import 'package:bootcamp_app/models/space.dart';
import 'package:bootcamp_app/models/tips.dart';
import 'package:bootcamp_app/providers/space_provider.dart';
import 'package:bootcamp_app/widgets/bottom_navbar_item.dart';
import 'package:bootcamp_app/widgets/city_card.dart';
import 'package:bootcamp_app/widgets/space_card.dart';
import 'package:bootcamp_app/widgets/tips_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var spaceProvider = Provider.of<SpaceProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(height: edge),
            // TITLE/HEADER
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Explore Now',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Mencari kosan yang cozy',
                style: greyTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            // POPULAR CITIES
            _buildSectionTitle('Popular Cities'),
            const SizedBox(height: 16),
            _buildCityList(),
            const SizedBox(height: 30),
            // RECOMMENDED SPACE
            _buildSectionTitle('Recommended Space'),
            const SizedBox(height: 16),
            _buildRecommendedSpaces(spaceProvider),
            const SizedBox(height: 30),
            // TIPS & GUIDANCE
            _buildSectionTitle('Tips & Guidance'),
            const SizedBox(height: 16),
            _buildTipsList(),
            SizedBox(height: 100 + edge),
          ],
        ),
      ),
      floatingActionButton: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: edge),
      child: Text(
        title,
        style: regularTextStyle.copyWith(fontSize: 16),
      ),
    );
  }

  Widget _buildCityList() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 24),
          CityCard(City(id: 1, name: 'Jakarta', imageUrl: 'assets/city1.png')),
          const SizedBox(width: 20),
          CityCard(
            City(
              id: 2,
              name: 'Bandung',
              imageUrl: 'assets/city2.png',
              isPopular: true,
            ),
          ),
          const SizedBox(width: 20),
          CityCard(City(id: 3, name: 'Surabaya', imageUrl: 'assets/city3.png')),
          const SizedBox(width: 20),
          CityCard(
              City(id: 4, name: 'Palembang', imageUrl: 'assets/city4.png')),
          const SizedBox(width: 20),
          CityCard(
            City(
              id: 5,
              name: 'Aceh',
              imageUrl: 'assets/city5.png',
              isPopular: true,
            ),
          ),
          const SizedBox(width: 20),
          CityCard(City(id: 6, name: 'Bogor', imageUrl: 'assets/city6.png')),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildRecommendedSpaces(SpaceProvider spaceProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edge),
      child: FutureBuilder<List<Space>>(
        future: spaceProvider.getRecommendedSpaces(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Space> data = snapshot.data!;
            int index = 0;
            return Column(
              children: data.map((item) {
                index++;
                return Container(
                  margin: EdgeInsets.only(top: index == 1 ? 0 : 30),
                  child: SpaceCard(item),
                );
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTipsList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edge),
      child: Column(
        children: [
          TipsCard(
            Tips(
              id: 1,
              title: 'City Guidelines',
              imageUrl: 'assets/tips1.png',
              updatedAt: '20 Apr',
            ),
          ),
          const SizedBox(height: 20),
          TipsCard(
            Tips(
              id: 2,
              title: 'Jakarta Fairship',
              imageUrl: 'assets/tips2.png',
              updatedAt: '11 Dec',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width - (2 * edge),
      margin: EdgeInsets.symmetric(horizontal: edge),
      decoration: BoxDecoration(
        color: const Color(0xffF6F7F8),
        borderRadius: BorderRadius.circular(23),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavbarItem(
            imageUrl: 'assets/icon_home.png',
            isActive: true,
          ),
          BottomNavbarItem(
            imageUrl: 'assets/icon_email.png',
            isActive: false,
          ),
          BottomNavbarItem(
            imageUrl: 'assets/icon_card.png',
            isActive: false,
          ),
          BottomNavbarItem(
            imageUrl: 'assets/icon_love.png',
            isActive: false,
          ),
        ],
      ),
    );
  }
}
