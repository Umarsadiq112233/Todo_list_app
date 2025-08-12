import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(height: 10),

                // About Us
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: const Text("About Us"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigation or dialog here
                  },
                ),
                const Divider(),

                // Contact Us
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: const Text("Contact Us"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigation or dialog here
                  },
                ),
                const Divider(),

                // Terms & Conditions
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.orange),
                  title: const Text("Terms & Conditions"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigation or dialog here
                  },
                ),
                const Divider(),

                // Share App
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.purple),
                  title: const Text("Share App"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Share app logic
                  },
                ),
                const Divider(),

                // Rate App
                ListTile(
                  leading: const Icon(Icons.star_rate, color: Colors.amber),
                  title: const Text("Rate App"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Open store rating
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
