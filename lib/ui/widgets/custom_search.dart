import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  final TextEditingController searchController;

  const CustomSearch({required this.searchController});

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    // Listener untuk mengubah status _showClearIcon
    widget.searchController.addListener(_updateClearIconVisibility);
  }

  @override
  void dispose() {
    // Jangan lupa untuk melepas listener saat widget di dispose
    widget.searchController.removeListener(_updateClearIconVisibility);
    super.dispose();
  }

  void _updateClearIconVisibility() {
    setState(() {
      _showClearIcon = widget.searchController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
      child: TextFormField(
        controller: widget.searchController,
        textCapitalization: TextCapitalization.sentences,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Visibility(
            visible: _showClearIcon,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                widget.searchController.clear();
              },
            ),
          ),
          labelStyle: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.grey,
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Colors.grey,
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFFFF5963),
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 247, 244, 244),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFF5963),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFF5963),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 249, 248, 248),
        ),
        style: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Colors.black,
          fontSize: 14,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: Colors.grey,
        onChanged: (value) {
          // Diimplementasikan pada HomePage
        },
      ),
    );
  }
}
