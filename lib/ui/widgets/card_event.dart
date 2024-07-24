import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/resources/datautil.dart';
import 'package:mavent/ui/pages/homepage/booking/detail_page.dart';

class CardEvent extends StatelessWidget {
  final EventModel event;

  const CardEvent({Key? key, required this.event}) : super(key: key);

  void _navigateToDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailEventPage(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetailPage(context),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF15161E),
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2, // Maksimal 2 baris untuk judul
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'By ${event.promoter}',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF15161E),
                          fontSize: 15,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2, // Maksimal 2 baris untuk judul
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.access_time, // Icon waktu
                            color: Color(0xFF606A85),
                            size: 16,
                          ),
                          SizedBox(width: 4), // Spasi antara ikon dan teks
                          Text(
                            DateUtil.formatDate(event.date), // Teks tanggal
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF606A85),
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ', ',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF606A85),
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                              width:
                                  8), // Spasi lebih besar antara teks dan ikon lokasi
                          Icon(
                            Icons.location_on, // Icon lokasi
                            color: Color(0xFF606A85),
                            size: 16,
                          ),
                          SizedBox(
                              width: 4), // Spasi antara ikon dan teks lokasi
                          Expanded(
                            child: Text(
                              event.location, // Teks lokasi
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF606A85),
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
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
