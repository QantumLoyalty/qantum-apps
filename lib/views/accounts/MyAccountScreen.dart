import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';

import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../../view_models/MyAccountProvider.dart';
import 'widgets/AccountsAppBar.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  MyAccountProvider myAccountProvider = MyAccountProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.clear,
          size: 30,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => myAccountProvider,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AccountsAppBar(
                  showBackButton: false, title: AppStrings.txtMyAccount),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          myAccountProvider.accountOptions.keys
                              .elementAt(index),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                        trailing: Icon(Icons.chevron_right,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                        onTap: () {
                          AppHelper.printMessage(
                              myAccountProvider.accountOptions[myAccountProvider
                                  .accountOptions.keys
                                  .elementAt(index)]!);
                          AppNavigator.navigateTo(
                              context,
                              myAccountProvider.accountOptions[myAccountProvider
                                  .accountOptions.keys
                                  .elementAt(index)]!);
                        },
                      );
                    },
                    itemCount: myAccountProvider.accountOptions.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myAccountProvider.dispose();
  }
}
