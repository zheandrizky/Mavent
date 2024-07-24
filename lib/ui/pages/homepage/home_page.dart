import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/services/auth_service.dart';
import 'package:mavent/services/event_service.dart';
import 'package:mavent/services/ticketmaster_service.dart';
import 'package:mavent/ui/pages/homepage/categories/music_pages.dart';
import 'package:mavent/ui/pages/homepage/categories/others_pages.dart';
import 'package:mavent/ui/pages/homepage/categories/sports_pages.dart';
import 'package:mavent/ui/pages/homepage/new_event/tambah_event.dart';
import 'package:mavent/ui/widgets/card_event.dart';
import 'package:mavent/ui/widgets/custom_search.dart';
import 'package:mavent/ui/widgets/navigation_bar.dart';
import 'package:mavent/ui/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  Future<List<EventModel>>? _futureEvents;
  String _userName = 'Loading...';
  final AuthService _authService = AuthService();
  final EventService _eventService = EventService();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_updateSearchQuery);
    _futureEvents = _fetchEvents('');
    _loadUserName();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery() {
    final newQuery = _searchController.text;
    setState(() {
      searchQuery = newQuery;
      _futureEvents = _fetchEvents(newQuery);
    });
  }

  Future<List<EventModel>> _fetchEvents(String query) async {
    try {
      // Fetch events from API
      final apiEvents = await ApiService().fetchEvents(query);

      // Fetch events from Firebase
      final firebaseEvents = await _eventService.getUserEvents().first;

      // Combine both lists (assuming the IDs are unique)
      final combinedEvents = <EventModel>{};
      combinedEvents.addAll(apiEvents);
      combinedEvents.addAll(firebaseEvents);

      return combinedEvents.toList();
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  Future<void> _loadUserName() async {
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

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/appbar.png',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hi, $_userName',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile.png')),
                      ),
                      onPressed: _navigateToProfile,
                    ),
                  ],
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          CustomSearch(searchController: _searchController),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/button.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                              child: Text(
                                'Let\'s Make New Event',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TambahEvent()),
                                  );
                                },
                                icon: Icon(
                                  Icons.add_box,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Add New',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  textStyle: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14,
                                  ),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: Size(120, 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicPage()),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.music_note_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                'Music',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 3,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SportPage()),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.sports_baseball,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                'Sports',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 3,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtherEventsPage()),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.notes,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                'Others',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 3,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Upcoming Event',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<List<EventModel>>(
                    future: _futureEvents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No events found'));
                      }

                      final events = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CardEvent(event: event),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 0),
    );
  }
}
