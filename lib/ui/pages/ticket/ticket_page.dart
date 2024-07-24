import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mavent/models/ticket_model.dart';
import 'package:mavent/services/ticket_service.dart';
import 'package:mavent/ui/widgets/card_ticket.dart';
import 'package:mavent/ui/widgets/navigation_bar.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TicketService _ticketService = TicketService();
  User? _currentUser;
  List<TicketModel> _tickets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      try {
        List<TicketModel> tickets =
            await _ticketService.fetchTicketsForUser(_currentUser!.uid);
        setState(() {
          _tickets = tickets;
          _isLoading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to fetch tickets: $e'),
        ));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Tickets'),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _tickets.isNotEmpty
              ? ListView.builder(
                  itemCount: _tickets.length,
                  itemBuilder: (context, index) {
                    return CardTicket(ticket: _tickets[index]);
                  },
                )
              : Center(
                  child: Text('No tickets booked yet'),
                ),
      bottomNavigationBar: CustomNavbar(currentIndex: 1),
    );
  }
}
