import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/splash_bg.webp', fit: BoxFit.cover),
          Container(
            color: Colors.black.withOpacity(0.4), // Optional overlay
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),

              // ✅ VarsityGo logo (size increased)
              Image.asset(
                'assets/logo.png',
                height: 160, // Increased size
              ),

              SizedBox(height: 20),

              Text(
                "VarsityGo",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Get Started"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
