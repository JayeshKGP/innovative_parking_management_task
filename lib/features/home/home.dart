import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'discover_page.dart';
import 'orders_page.dart';
import 'wallet_page.dart';
import 'settings_page.dart';
import 'package:innovative_parking_management_task/core/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DiscoverPage(),
    OrdersPage(),
    WalletPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfbfb),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffffffff),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12,),
        unselectedItemColor: Color(0xff9f9fb5),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12,),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? SvgPicture.asset('assets/svg/discover-filled.svg')
            : SvgPicture.asset('assets/svg/discover.svg'),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? SvgPicture.asset('assets/svg/orders-filled.svg')
                : SvgPicture.asset('assets/svg/orders.svg'),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? SvgPicture.asset('assets/svg/wallet-filled.svg')
                : SvgPicture.asset('assets/svg/wallet.svg'),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3 ? SvgPicture.asset('assets/svg/settings-filled.svg')
                : SvgPicture.asset('assets/svg/settings.svg'),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
