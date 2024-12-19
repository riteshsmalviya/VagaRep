import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapWidget extends StatefulWidget {
  const FlutterMapWidget({super.key});

  @override
  FlutterMapWidgetState createState() => FlutterMapWidgetState();
}

class FlutterMapWidgetState extends State<FlutterMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter:
              LatLng(22.620186, 75.803574), // Center the map over London
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            // Display map tiles from any source
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            userAgentPackageName: 'com.example.app',
          ),
          RichAttributionWidget(
            // Include a stylish prebuilt attribution widget that meets all requirements
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(
                  Uri.parse('https://openstreetmap.org/copyright'),
                ), // (external)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
