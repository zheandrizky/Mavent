import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mavent/models/ticket_model.dart';

class TicketService {
  final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');

  Future<void> bookTickets({
    required String eventId,
    required String imageUrl,
    required String title,
    required String userId,
    required int ticketCount,
    required double totalPrice,
    required String promoter,
    required String location,
    required String date,
  }) async {
    try {
      await ticketsCollection.add({
        'eventId': eventId,
        'imageUrl': imageUrl,
        'title': title,
        'userId': userId,
        'ticketCount': ticketCount,
        'totalPrice': totalPrice,
        'timestamp': FieldValue.serverTimestamp(),
        'promoter': promoter,
        'location': location,
        'date': date,
      });
    } catch (e) {
      throw Exception('Failed to book tickets: $e');
    }
  }

  Future<List<TicketModel>> fetchTicketsForUser(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await ticketsCollection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs.map((doc) {
        return TicketModel(
          imageUrl: doc['imageUrl'],
          title: doc['title'],
          promoter: doc['promoter'],
          location: doc['location'],
          date: doc['date'],
          ticketCount: doc['ticketCount'],
          totalPrice: doc['totalPrice'],
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch tickets: $e');
    }
  }
}
