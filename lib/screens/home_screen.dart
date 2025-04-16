import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> buses = [
    {
      "name": "Shurjomukhi 1",
      "route": "Main Campus → Dhanmondi",
      "image": "assets/bus_a.png",
      "color": "#4285F4",
    },
    {
      "name": "Dolfin 1",
      "route": "Main Campus → Mirpur",
      "image": "assets/bus_b.jpg",
      "color": "#EA4335",
    },
    {
      "name": "Rojinigondha",
      "route": "Main Campus → Uttara",
      "image": "assets/bus_c.jpg",
      "color": "#FBBC05",
    },
    {
      "name": "Dolfin 2",
      "route": "Main Campus → Narayanganj",
      "image": "assets/bus_d.jpg",
      "color": "#34A853",
    },
    {
      "name": "Shurjomukhi 2",
      "route": "Main Campus → Baipail",
      "image": "assets/bus_e.jpg",
      "color": "#673AB7",
    },
    {
      "name": "Dolfin 3",
      "route": "Campus → Mirpur → Dhanmondi",
      "image": "assets/bus_d.jpg",
      "color": "#FF5722",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "VarsityGo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/selectUser');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Available Campus Buses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: buses.length,
              itemBuilder: (context, index) {
                Color busColor = Color(
                  int.parse(buses[index]["color"]!.substring(1, 7), radix: 16) +
                      0xFF000000,
                );

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/bus',
                          arguments: buses[index],
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: busColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Hero(
                                  tag: buses[index]["name"]!,
                                  child: Image.asset(
                                    buses[index]["image"]!,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    buses[index]["name"]!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    buses[index]["route"]!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.map),
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
    );
  }
}
