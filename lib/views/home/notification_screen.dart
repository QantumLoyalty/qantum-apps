import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/views/accounts/widgets/AccountsAppBar.dart';
import 'package:qantum_apps/views/common_widgets/AppScaffold.dart';

import '../../core/extensions/spacer_extension.dart';
import 'widgets/NotificationListTile.dart';

class NotificationsScreen extends StatefulWidget {
  final String userId;

  const NotificationsScreen({super.key, required this.userId});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadNotifications(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations loc = AppLocalizations.of(context)!;
    final notifications = context.watch<HomeProvider>().notifications;

    return AppScaffold(
        scaffoldBackground: AppThemeCustom.getAccountBackground(context),
        body: SafeArea(
            child: Column(children: [
          AccountsAppBar(showBackButton: true, title: loc.txtNotification),
          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: notifications.isEmpty
                      ? Center(
                          child: Text(
                          'No notifications yet',
                          style: TextStyle(
                            color: AppThemeCustom.getNotificationItemStyle(
                                context),
                          ),
                        ))
                      : RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          color: Theme.of(context).textSelectionTheme.selectionColor,
                          onRefresh: () => context
                              .read<HomeProvider>()
                              .refreshNotifications(),
                          child: ListView.separated(
                              itemCount: notifications.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return AppDimens.shape_10;
                              },
                              itemBuilder: (context, index) {
                                final n = notifications[index];
                                return Slidable(
                                    key: ValueKey(n.id),
                                    endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: 0.32,
                                      children: [
                                        CustomSlidableAction(
                                          onPressed: (context) {
                                            context
                                                .read<HomeProvider>()
                                                .deleteNotification(n);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFB11921),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            margin:
                                                const EdgeInsets.only(left: 12),
                                            child: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.delete,
                                                    color: Colors.white,
                                                    size: 28,
                                                  ),
                                                  6.h,
                                                  const Text(
                                                    "DELETE",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white
                                              .withValues(alpha: 0.25),
                                        ),
                                        child: NotificationListTile(
                                          key: ValueKey(n.id),
                                          notification: n,
                                          onTap: () {
                                            context
                                                .read<HomeProvider>()
                                                .onTapNotification(n);
                                          },
                                        )));
                              }))))
        ])));
  }
}
