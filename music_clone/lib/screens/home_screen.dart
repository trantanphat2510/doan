import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_clone/widgets/pages/favorite_page.dart';
import 'package:music_clone/widgets/pages/home_page.dart';
import 'package:music_clone/widgets/pages/profile_page.dart';
import 'package:music_clone/widgets/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        toolbarHeight: 70,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage("assets/spotify_logo.png"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: CupertinoIcons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: CupertinoIcons.search,
                text: 'Tìm kiếm',
              ),
              GButton(
                icon: CupertinoIcons.heart,
                text: 'Yêu thích',
              ),
              GButton(
                icon: CupertinoIcons.person,
                text: 'Hồ sơ',
              )
            ],
          ),
        ),
      ),
    );
  }
}
