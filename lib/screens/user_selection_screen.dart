import 'package:flutter/material.dart';
import 'login_student.dart';
import 'login_driver.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    void navigateToLogin(String userType) {
      if (userType == 'student') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginStudentScreen()),
        );
      } else if (userType == 'driver') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginDriverScreen()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select User Type"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.primaryColor.withOpacity(0.8),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo or icon
                Hero(
                  tag: 'appLogo',
                  child: Icon(
                    Icons.directions_bus_filled,
                    size: size.width * 0.3,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Welcome to Bus Tracker",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Please select your role to continue",
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),

                // Student Button
                Hero(
                  tag: 'studentLogin',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => navigateToLogin('student'),
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.school,
                              size: 30,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Login as Student",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Driver Button
                Hero(
                  tag: 'driverLogin',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => navigateToLogin('driver'),
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.drive_eta,
                              size: 30,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Login as Driver",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Help text
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Need Help?"),
                            content: const Text(
                              "Select 'Student' if you're a passenger tracking buses. "
                              "Select 'Driver' if you're operating a bus and need to update its location.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Text(
                    "Not sure which to choose?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
