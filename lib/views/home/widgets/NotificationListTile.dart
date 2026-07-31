import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';

import '../../../data/models/notification_model.dart';
import '../../../view_models/HomeProvider.dart';

class NotificationListTile extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationListTile(
      {super.key, required this.notification, required this.onTap});

  @override
  State<NotificationListTile> createState() => _NotificationListTileState();
}

class _NotificationListTileState extends State<NotificationListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.25),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        onTap: () =>
            context.read<HomeProvider>().onTapNotification(widget.notification),
        leading: widget.notification.imageUrl != null &&
                widget.notification.imageUrl!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.notification.imageUrl!,
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
                      child: const Icon(Icons.image_not_supported_outlined,
                          size: 20),
                    );
                  },
                ),
              )
            : null,
        title: Text(
          widget.notification.title,
          style: TextStyle(
            fontWeight: widget.notification.isRead
                ? FontWeight.normal
                : FontWeight.bold,
            color: AppThemeCustom.getNotificationItemStyle(context),
          ),
        ),
        subtitle: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.notification.body,
              maxLines: _isExpanded ? null : 2,
              overflow:
                  _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                color: AppThemeCustom.getNotificationItemStyle(context),
              ),
            ),
          ),
        ),
        trailing: widget.notification.isRead
            ? null
            : const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.blue,
              ),
      ),
    );
  }
}
