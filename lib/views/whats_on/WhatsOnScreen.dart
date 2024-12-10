import 'package:flutter/material.dart';
import 'package:qantum_apps/views/whats_on/widget/WhatsOnItem.dart';

class WhatsOnScreen extends StatelessWidget {
  const WhatsOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
      child: ListView.separated(

        itemBuilder: (context, index) {
          return const WhatsOnItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Theme.of(context).primaryColor,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
