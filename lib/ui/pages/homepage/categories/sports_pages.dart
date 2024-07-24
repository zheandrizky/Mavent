import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/ui/widgets/card_event.dart';
import 'package:mavent/ui/pages/homepage/booking/detail_page.dart';

class SportPage extends StatefulWidget {
  const SportPage({super.key});

  @override
  State<SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<EventModel>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = _fetchEvents();
  }

  Future<List<EventModel>> _fetchEvents() async {
    final response = await http.get(Uri.parse(
        'https://app.ticketmaster.com/discovery/v2/events.json?size=5&apikey=RHwAPQXmD6FYGazlXrFptM2InjWlpN6O&classificationName=sports'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List eventsJson = json['_embedded']['events'];
      return eventsJson
          .map((eventJson) => EventModel.fromJson(eventJson))
          .toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Center(
          child: FutureBuilder<List<EventModel>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No events found');
              }

              final events = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}
