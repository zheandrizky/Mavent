import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mavent/models/event_model.dart';

class EventService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getCurrentUserName() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      return userData.data()?['name'];
    }
    return null;
  }

  Stream<List<EventModel>> getUserEvents() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('events')
          .where('userId', isEqualTo: user.uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return EventModel.fromFirebase(doc);
        }).toList();
      });
    } else {
      return Stream.value([]);
    }
  }

  Future<void> addEvent(EventModel event) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('events').add({
        'userId': user.uid,
        'title': event.title,
        'promoter': event.promoter,
        'description': event.description,
        'date': event.date,
        'image': event.image,
        'location': event.location,
        'city': event.city,
        'country': event.country,
        'price': event.price,
      });
    }
  }

  Future<void> updateEvent(EventModel updatedEvent) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(updatedEvent.id)
          .update(updatedEvent.toJson());
    } catch (e) {
      print('Error updating event: $e');
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).delete();
  }
}
