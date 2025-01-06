import 'package:event_app/screens/profile_page.dart';
import 'package:event_app/screens/event_page.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/screens/tickets_page.dart';
import 'package:flutter/material.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyBottomNavigation();
  }
}

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_rounded,
              color: currentPageIndex == 0 ? Colors.white : null,
            ),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.discount_rounded,
              color: currentPageIndex == 1 ? Colors.white : null
            ),
            selectedIcon: const Icon(
              Icons.discount_rounded,
              color: Colors.white,
            ),
            label: 'Tickets',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_rounded,
              color: currentPageIndex == 2 ? Colors.white : null
            ),
            selectedIcon: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
            ),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: currentPageIndex == 3 ? Colors.white : null
            ),
            selectedIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Account',
          ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const TicketsPage(),
        const EventPage(),
        const ProfilePage(),
      ][currentPageIndex],
    );
  }
}
