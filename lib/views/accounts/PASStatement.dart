import 'package:flutter/material.dart';

import '../../core/utils/AppStrings.dart';
import 'widgets/AccountsAppBar.dart';

class PASStatement extends StatelessWidget {
  const PASStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Column(
          children: [
            AccountsAppBar(
                showBackButton: true, title: AppStrings.txtPASStatement),
            Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).primaryColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
