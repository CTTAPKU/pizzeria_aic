import 'package:flutter/material.dart';
import 'package:pizzeria_aic/core/constants/app_colors.dart';
import 'package:pizzeria_aic/features/menu/presentation/order.dart';

class PizzaCard extends StatelessWidget {
  final String pizzaName;
  final String pictureURL;
  final String id;

  const PizzaCard(
      {super.key,
      required this.pizzaName,
      required this.pictureURL,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        clipBehavior: Clip.antiAlias,
        color: AppColors.darkPrimary,
        child: InkWell(
          splashColor: AppColors.darkAccent.withValues(alpha: 0.6),
          highlightColor: AppColors.darkAccent.withValues(alpha: 0.2),
          splashFactory: InkRipple.splashFactory,
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 70));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Order(id: id, pizzaName: pizzaName),
                maintainState: false,
              ),
            );
          },
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff1E201E), Colors.transparent],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter),
                    ),
                    child: Ink.image(
                      image: NetworkImage(pictureURL),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Text(
                      pizzaName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
