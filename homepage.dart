import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoopy/bookmark.dart';
import 'package:scoopy/information_page.dart';
import 'package:scoopy/home_page.dart';
import 'package:scoopy/news_model.dart';
import 'package:scoopy/search.dart';

import 'package:scoopy/settingspage.dart';
import 'package:scoopy/thememanager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomePagee(),
    SearchPage(),
    InformationsPage(),
    BookmarkPage(),
  ];

  ThemeManager _themeManager = ThemeManager();
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF2D365C),
          title: const Text(
            'scoopy',
            style: TextStyle(
                fontFamily: 'Coolvetica',
                fontSize: 34,
                letterSpacing: 3,
                color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SetPage()));
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF2D365C),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 2,
          currentIndex: _selectedIndex,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              label: 'Ana Sayfa',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Kategori',
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Kaydedilenler',
              icon: Icon(
                Icons.podcasts,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Ayarlar',
              icon: Icon(
                Icons.bookmark,
              ),
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
