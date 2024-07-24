import 'package:flutter/material.dart';
import 'package:mavent/models/ticket_model.dart';
import 'package:mavent/ui/pages/ticket/detail_ticket.dart';

class CardTicket extends StatelessWidget {
  final TicketModel ticket;

  const CardTicket({Key? key, required this.ticket}) : super(key: key);

  void _navigateToDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTicketPage(ticket: ticket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetailPage(context),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0x00E5E7EB), width: 1),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(ticket.imageUrl,
                        width: 100, height: 100, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                          maxLines: 2, // Maksimal 2 baris untuk judul
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Color(0xFF606A85), size: 20),
                            SizedBox(width: 4),
                            Text(ticket.location,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF606A85))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.airplane_ticket,
                                color: Color(0xFF606A85), size: 20),
                            SizedBox(width: 4),
                            Text('Tiket (${ticket.ticketCount})',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF606A85))),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.date_range,
                                color: Color(0xFF606A85), size: 20),
                            SizedBox(width: 4),
                            Text(ticket.date,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF606A85))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Berhasil',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF606A85)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
