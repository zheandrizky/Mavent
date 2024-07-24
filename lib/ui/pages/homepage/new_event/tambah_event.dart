import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/services/event_service.dart';

import 'package:mavent/ui/widgets/custom_input_form.dart';

class TambahEvent extends StatefulWidget {
  const TambahEvent({Key? key}) : super(key: key);

  @override
  _TambahEventState createState() => _TambahEventState();
}

class _TambahEventState extends State<TambahEvent> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _tempatController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final EventService _eventService = EventService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tambah Event',
              style: TextStyle(
                fontFamily: 'Outfit',
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Input form untuk URL gambar
                CustomInputForm(
                  controller: _imageUrlController,
                  label: 'URL Gambar',
                  hint: 'Masukkan URL gambar event',
                ),
                SizedBox(height: 16.0),

                // Preview gambar (jika URL gambar dimasukkan)
                _imageUrlController.text.isNotEmpty
                    ? Image.network(
                        _imageUrlController.text,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : SizedBox.shrink(),

                SizedBox(height: 16.0),
                CustomInputForm(
                  controller: _judulController,
                  label: 'Judul',
                  hint: 'Masukkan judul event',
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 16.0),
                CustomInputForm(
                  controller: _deskripsiController,
                  label: 'Deskripsi',
                  hint: 'Masukkan deskripsi event',
                  maxLines: 3,
                ),
                SizedBox(height: 16.0),
                CustomInputForm(
                  controller: _tanggalController,
                  label: 'Tanggal',
                  hint: 'Masukkan tanggal event',
                  keyboardType: TextInputType.datetime,
                ),
                SizedBox(height: 16.0),
                CustomInputForm(
                  controller: _tempatController,
                  label: 'Tempat',
                  hint: 'Masukkan tempat event',
                ),
                // SizedBox(height: 16.0),
                // CustomInputForm(
                //   controller: _lokasiController,
                //   label: 'Lokasi',
                //   hint: 'Masukkan lokasi event',
                // ),
                SizedBox(height: 16.0),
                CustomInputForm(
                  controller: _hargaController,
                  label: 'Harga',
                  hint: 'Masukkan harga event',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24.0),
                // Button untuk menyimpan event
                ElevatedButton(
                  onPressed: () async {
                    final promoterName =
                        await _eventService.getCurrentUserName();
                    if (promoterName == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to get user name')),
                      );
                      return;
                    }

                    final newEvent = EventModel(
                      id: '', // Firebase will generate an ID
                      title: _judulController.text,
                      promoter:
                          promoterName, // You might want to add a promoter field
                      description: _deskripsiController.text,
                      date: _tanggalController.text,
                      image: _imageUrlController.text,
                      location: _tempatController.text,
                      city: '', // Add city field if necessary
                      country: '', // Add country field if necessary
                      price: double.parse(_hargaController.text),
                    );

                    await _eventService.addEvent(newEvent);

                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50), // Atur ukuran minimum tombol
                    backgroundColor: Color(0xFF4B39EF), // Set button color
                    padding: EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12), // Set padding
                  ),
                  child: Text(
                    'Simpan Event',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            )),
      ),
    );
  }
}
