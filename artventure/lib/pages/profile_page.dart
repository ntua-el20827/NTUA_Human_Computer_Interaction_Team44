import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/pages/login_page.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: primaryColor,
                radius: 77,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/no_user.jpg"),
                  radius: 75,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                profile!.fullName ?? "",
                style: const TextStyle(fontSize: 28, color: primaryColor),
              ),
              Text(
                profile!.email ?? "",
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),
              Button(
                  label: "SIGN UP",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }),
              ListTile(
                leading: const Icon(Icons.person, size: 30),
                subtitle: const Text("Full name"),
                title: Text(profile!.fullName ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.email, size: 30),
                subtitle: const Text("Email"),
                title: Text(profile!.email ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle, size: 30),
                subtitle: Text(profile!.username),
                title: const Text("admin"),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
