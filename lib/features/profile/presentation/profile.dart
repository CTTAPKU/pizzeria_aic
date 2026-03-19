import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/cascading_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizzeria_aic/features/profile/data/datasources/user_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профіль"),
        centerTitle: true,
        actions: const [CascadingMenu()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 15),
                child: const CircleAvatar(
                  radius: 83,
                  child: Text("avatar"),
                ),
              ),
              FutureBuilder(
                future: UserData().getUserByUId(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic>? data =
                        snapshot.data as Map<String, dynamic>;
                    return Text(
                        "Ім'я: ${data['firstName']}  ${data['lastName']}");
                  } else {
                    return const Text("loading...");
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Divider(),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text("Ваші бонуси"),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Доступні"),
                  Text("Всього"),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("0"),
                  Text("0"),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, bottom: 24, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    SystemNavigator.pop();
                  },
                  child: const Text("Вихід")),
            ),
          )
        ],
      ),
    );
  }
}
