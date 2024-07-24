import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String title;
  String promoter;
  String description;
  String date;
  String image;
  String location;
  String city;
  String country;
  double price;
  // String category;

  EventModel({
    required this.id,
    required this.title,
    required this.promoter,
    required this.description,
    required this.date,
    required this.image,
    required this.location,
    required this.city,
    required this.country,
    required this.price,
    // required this.category,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      promoter: json['promoter']?['name'] ?? 'Unknown Promoter',
      description: json['_embedded']['venues']?[0]['generalInfo']
              ?['generalRule'] ??
          'Details are currently unavailable. Please check back later.',
      date: json['dates']['start']['localDate'] ?? '',
      image: json['images']?[0]?['url'] ?? '',
      location: json['_embedded']['venues']?[0]['name'] ?? 'Unknown Location',
      city: json['_embedded']['venues']?[0]['city']?['name'] ?? 'Unknown city',
      country: json['_embedded']['venues']?[0]['country']?['name'] ??
          'Unknown Country',
      price: (json['priceRanges']?[0]['min'] ?? 50).toDouble(),
      // category: json['classifications']?[0]['segment']?[0]['name'] ??
      //     'Unknown Category',
    );
  }

  // Factory constructor from Firebase DocumentSnapshot
  factory EventModel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      promoter: data['promoter'] ?? 'Unknown Promoter',
      description: data['description'] ??
          'Details are currently unavailable. Please check back later.',
      date: data['date'] ?? '',
      image: data['image'] ?? '',
      location: data['location'] ?? 'Unknown Location',
      city: data['city'] ?? 'Unknown city',
      country: data['country'] ?? 'Unknown Country',
      price: (data['price'] ?? 50).toDouble(),
      // category: data['category'] ?? 'Unknown Category',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'promoter': promoter,
        'description': description,
        'date': date,
        'image': image,
        'location': location,
        'city': city,
        'country': country,
        'price': price,
        // 'category': category,
      };
}
