import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/resources/datautil.dart';
import 'package:mavent/services/auth_service.dart';
import 'package:mavent/services/ticket_service.dart';

class DetailEventPage extends StatefulWidget {
  final EventModel event;

  const DetailEventPage({Key? key, required this.event}) : super(key: key);

  @override
  _DetailEventPageState createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {
  late EventModel _event;
  int _ticketCount = 0; // State untuk menyimpan jumlah tiket yang akan dibeli
  final TicketService _ticketService = TicketService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _event = widget.event;
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  String _userName = 'Loading...';

  final AuthService _authService = AuthService();

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userData = await _authService.getUserData();
      setState(() {
        _userName = userData['name'];
      });
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _userName = 'Error loading user data';
      });
    }
  }

  Future<void> _bookTickets() async {
    if (_ticketCount <= 0) {
      // Display error if no tickets are selected
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select at least one ticket'),
      ));
      return;
    }

    try {
      await _ticketService.bookTickets(
        eventId: _event.id,
        imageUrl: _event.image,
        title: _event.title,
        userId: _currentUser!.uid, // Replace with actual user ID
        ticketCount: _ticketCount,
        promoter: _userName,
        totalPrice: _ticketCount * _event.price,
        location: _event.location,
        date: _event.date,
      );

      // Navigate to a confirmation page or display a success message
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tickets booked successfully!'),
      ));
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to book tickets: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(_event.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_outlined),
            onPressed: () {
              // Implementasi aksi tambahan di sini
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _event.image,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_event.city}, ${_event.country}',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _event.title,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By ${_event.promoter}',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _event.description,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Timeline Event',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildTimelineEvent(
                      'Opening Event', DateUtil.formatDate(_event.date)),
                  SizedBox(height: 8),
                  _buildTimelineEvent('Location', _event.location),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Tickets',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (_ticketCount > 0) {
                                    setState(() {
                                      _ticketCount--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                '$_ticketCount',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  letterSpacing: 0,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _ticketCount++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Total',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            '\$${(_ticketCount * _event.price).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _bookTickets,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4B39EF),
                      minimumSize: Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEvent(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              letterSpacing: 0,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
