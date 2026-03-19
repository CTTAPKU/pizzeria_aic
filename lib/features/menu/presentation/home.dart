import 'package:flutter/material.dart';
import 'package:pizzeria_aic/features/menu/data/datasources/menu_data.dart';
import 'package:pizzeria_aic/core/widgets/cascading_menu.dart';
import 'package:pizzeria_aic/features/menu/presentation/widgets/pizza_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Меню"),
        centerTitle: true,
        actions: const [CascadingMenu()],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: MenuData().getMenuData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List<Map<String, dynamic>>;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return PizzaCard(
                      pizzaName: data[index]["pizzaName"],
                      pictureURL: data[index]["pictureURL"],
                      id: data[index]["id"]);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
