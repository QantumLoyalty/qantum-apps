import 'package:flutter/material.dart';

class BluewaterScaffoldBackground extends StatelessWidget {
  const BluewaterScaffoldBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        top: 0,
        left: 0,
        right: 0,
        child: Stack(
          children: [
            Positioned(child: Container(color: Theme.of(context).primaryColor,),top: 0,bottom: 0,left: 0,right: 0,),
            Positioned(
              top: 0,
              right: -50,
              child: IgnorePointer(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      "assets/bluewaterCaptainsClub/top_right_main.png",width: 220,height: 220,color: Colors.white,)),
              ),
            ),
            Positioned(
              bottom: 0,
              left: -50,
              child: IgnorePointer(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      "assets/bluewaterCaptainsClub/bottom_left_main.png",width: 220,height: 220,color: Colors.white,)),
              ),
            )
          ],
        ));
  }
}
