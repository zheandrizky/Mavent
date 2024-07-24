import 'package:flutter/material.dart';
import 'package:mavent/models/event_model.dart';
import 'package:mavent/services/event_service.dart'; // Pastikan import service yang sesuai
import 'package:mavent/ui/widgets/custom_input_form.dart';

class EditEventPage extends StatefulWidget {
  final EventModel event;

  const EditEventPage({Key? key, required this.event}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  late TextEditingController _tanggalController;
  late TextEditingController _tempatController;
  late TextEditingController _lokasiController;
  late TextEditingController _hargaController;

  final EventService _eventService =
      EventService(); // Instance dari EventService

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.event.title);
    _deskripsiController =
        TextEditingController(text: widget.event.description);
    _tanggalController = TextEditingController(text: widget.event.date);
    _tempatController = TextEditingController(text: widget.event.location);
    _lokasiController = TextEditingController(text: widget.event.city);
    _hargaController =
        TextEditingController(text: widget.event.price.toString());
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    _tanggalController.dispose();
    _tempatController.dispose();
    _lokasiController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    // Menyiapkan data baru dari input form
    final updatedEvent = EventModel(
      id: widget.event.id, // Pastikan ID tidak berubah
      title: _judulController.text,
      description: _deskripsiController.text,
      date: _tanggalController.text,
      location: _tempatController.text,
      city: _lokasiController.text,
      price: double.tryParse(_hargaController.text) ?? 0.0,
      promoter: widget.event.promoter,
      image: widget.event.image,
      country: widget.event.country,
    );

    try {
      // Panggil metode untuk update event dari EventService
      await _eventService.updateEvent(updatedEvent);

      // Jika sukses, kembali ke halaman sebelumnya
      Navigator.pop(context);
    } catch (e) {
      // Tangani error dengan sesuaikan dengan kebutuhan aplikasi Anda
      print('Error updating event: $e');
      // Tampilkan pesan error kepada pengguna jika perlu
    }
  }

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
              'Edit Event',
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
              CustomInputForm(
                controller: _judulController,
                label: 'Judul',
                hint: 'Masukkan judul event',
              ),
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
              SizedBox(height: 16.0),
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
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  backgroundColor: Color(0xFF4B39EF), // Set button color
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // Set padding
                ),
                child: Text(
                  'Simpan Perubahan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
