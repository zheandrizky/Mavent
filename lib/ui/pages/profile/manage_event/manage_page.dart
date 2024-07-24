import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/ui/pages/profile/manage_event/edit_event_page.dart';
import 'package:mavent/ui/widgets/card_manage.dart';
import 'package:mavent/services/event_service.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  final EventService _firebaseService = EventService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text('Manage Events'),
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
      body: StreamBuilder<List<EventModel>>(
        stream: _firebaseService.getUserEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          }

          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return CardManage(
                event: events[index],
                onDeletePressed: () async {
                  await _firebaseService.deleteEvent(events[index].id);
                  setState(() {});
                },
                onEditPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEventPage(event: events[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
