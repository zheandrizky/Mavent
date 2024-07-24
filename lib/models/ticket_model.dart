class TicketModel {
  final String imageUrl;
  final String title;
  final String promoter;
  final String location;
  final String date;
  final int ticketCount;
  final double totalPrice;


  TicketModel({
    required this.imageUrl,
    required this.title,
    required this.promoter,
    required this.location,
    required this.date,
    required this.ticketCount,
    required this.totalPrice,
  });
}
