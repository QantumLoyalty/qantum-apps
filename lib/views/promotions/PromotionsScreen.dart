import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

class PromotionsScreen extends StatelessWidget {
  List<Color> colorsList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.blueGrey
  ];

  PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PageView.builder(
          itemCount: colorsList.length,
          controller: PageController(viewportFraction: 0.8),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  AppNavigator.navigateTo(
                      context, AppNavigator.promotionDetail);
                },
                child: Card(
                  color: colorsList[index],
                ),
              ),
            );
          }),
    );
  }
}
