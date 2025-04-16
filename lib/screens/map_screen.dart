import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isTracking = false;
  int _selectedBusIndex = 0;
  final List<String> _buses = [
    'Surjomukhi 1',
    'Dolphin 1',
    'Rojinigondha',
    'Surjomukhi 2',
  ];

  late final MapController _mapController;
  LatLng _initialPosition = LatLng(23.777176, 90.399452); // DU coordinates
  LatLng? _currentBusPosition;
  Marker? _busMarker;
  Timer? _locationUpdateTimer;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Bus Tracking"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshMap),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(center: _initialPosition, zoom: 15.0),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (_busMarker != null) MarkerLayer(markers: [_busMarker!]),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: _selectedBusIndex,
                  decoration: InputDecoration(
                    labelText: 'Select Bus',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  items: List.generate(_buses.length, (index) {
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(_buses[index]),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedBusIndex = value;
                      });
                    }
                  },
                ),
                SizedBox(height: 12),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_bus,
                          size: 40,
                          color: Colors.deepPurple,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _buses[_selectedBusIndex],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "ETA: ${_isTracking ? '8 mins' : '--'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(
                            _isTracking ? 'LIVE' : 'OFFLINE',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              _isTracking ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _toggleTracking,
                        icon: Icon(_isTracking ? Icons.stop : Icons.play_arrow),
                        label: Text(
                          _isTracking ? 'Stop Tracking' : 'Start Tracking',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isTracking
                                  ? Colors.redAccent
                                  : Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: _centerMap,
                        icon: Icon(Icons.my_location),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleTracking() {
    setState(() {
      _isTracking = !_isTracking;
    });

    if (_isTracking) {
      _startTrackingBus();
    } else {
      _stopTrackingBus();
    }
  }

  void _startTrackingBus() {
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await _fetchBusLocation();
    });
    _fetchBusLocation();
  }

  void _stopTrackingBus() {
    _locationUpdateTimer?.cancel();
    setState(() {
      _busMarker = null;
    });
  }

  Future<void> _fetchBusLocation() async {
    try {
      // Simulated data (replace with real API logic)
      final simulatedPosition = LatLng(
        _initialPosition.latitude + (0.001 * (_selectedBusIndex + 1)),
        _initialPosition.longitude + (0.001 * (_selectedBusIndex + 1)),
      );

      setState(() {
        _currentBusPosition = simulatedPosition;
        _updateBusMarker();
        _moveCameraToBus();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to get bus location: $e")));
    }
  }

  void _updateBusMarker() {
    if (_currentBusPosition == null) return;

    _busMarker = Marker(
      width: 40.0,
      height: 40.0,
      point: _currentBusPosition!,
      builder:
          (ctx) =>
              Icon(Icons.directions_bus, color: Colors.deepPurple, size: 40),
    );
  }

  void _moveCameraToBus() {
    if (_currentBusPosition != null) {
      _mapController.move(_currentBusPosition!, 15.0);
    }
  }

  Future<void> _refreshMap() async {
    if (_isTracking) {
      await _fetchBusLocation();
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Map refreshed")));
  }

  Future<void> _centerMap() async {
    try {
      if (_isTracking && _currentBusPosition != null) {
        _moveCameraToBus();
      } else {
        final position = await Geolocator.getCurrentPosition();
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          15.0,
        );
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Map centered")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to center map: $e")));
    }
  }
}
