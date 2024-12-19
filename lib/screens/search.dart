import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vagabondapp/screens/homepage.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  List<String> _selectedPlaces = [];
  String _errorMessage = '';

  // Function to search places using OpenStreetMap API
  Future<void> searchPlaces(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load search results';
      });
    }
  }

  // Function to handle place selection
  void selectPlace(String placeName) {
    setState(() {
      _selectedPlaces.add(placeName);
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(selectedPlaces: _selectedPlaces),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(selectedPlaces: _selectedPlaces),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Places'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a place...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => searchPlaces(_searchController.text),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final place = _searchResults[index];
                    return ListTile(
                      title: Text(place['display_name']),
                      onTap: () => selectPlace(place['display_name']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
