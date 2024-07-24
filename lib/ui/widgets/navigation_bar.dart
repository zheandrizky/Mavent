import 'package:flutter/material.dart';
import 'package:mavent/ui/pages/homepage/home_page.dart';
import 'package:mavent/ui/pages/ticket/ticket_page.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;

  CustomNavbar({required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = TicketPage();
        break;
      default:
        page = HomePage();
    }
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Tickets',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Color(0xFF4B39EF),
          onTap: (index) => _onItemTapped(context, index),
        ),
      ),
    );
  }
}
