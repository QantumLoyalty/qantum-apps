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
        child: Column(
          children: [
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
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor),
                    ))
                    : RefreshIndicator(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  color:
                  Theme.of(context).textSelectionTheme.selectionColor,
                  onRefresh: () =>
                      context.read<HomeProvider>().refreshNotifications(),
                  child: ListView.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return AppDimens.shape_10;
                    },
                    itemBuilder: (context, index) {
                      final n = notifications[index];
                      return Slidable(
                        key: ValueKey(n.id),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.22,
                          children: [
                            CustomSlidableAction(
                              onPressed: (context) {
                                context.read<HomeProvider>().deleteNotification(n);
                              },
                              backgroundColor: Colors.transparent,
                              padding:  EdgeInsets.only(left:8,right: 8),
                              child:  Material(
                                  color: Color(0xFFB11921)
                                      .withOpacity(0.4),
                                  borderRadius:
                                  BorderRadius
                                      .circular(10),
                                  child: const Padding(
                                      padding:
                                      EdgeInsets.all(
                                          15),
                                      child: Icon(
                                        CupertinoIcons
                                            .delete,
                                        color: Color(0xFFB11921),
                                        size: 32,
                                      ))
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                          child: ListTile(
                            onTap: () => context
                                .read<HomeProvider>()
                                .onTapNotification(n),
                            leading: n.imageUrl != null && n.imageUrl!.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                n.imageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const SizedBox(
                                    width: 48,
                                    height: 48,
                                    child: Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    color: Colors.white.withValues(alpha: 0.15),
                                    child: const Icon(Icons.image_not_supported_outlined, size: 20),
                                  );
                                },
                              ),
                            )
                                : null,
                            title: Text(
                              n.title,
                              style: TextStyle(
                                  fontWeight: n.isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            subtitle: Text(
                              n.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            trailing: n.isRead
                                ? null
                                : const CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}