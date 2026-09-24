import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  String _formatNotificationTime(BuildContext context, DateTime receivedAt) {
    final local = receivedAt.toLocal(); // UTC -> phone timezone
    final now = DateTime.now();
    final diff = now.difference(local);
    final is24h = MediaQuery.alwaysUse24HourFormatOf(context);
    print(is24h);

    String timeStr() => is24h
        ? DateFormat('HH:mm').format(local)
        : DateFormat('h:mma').format(local).toLowerCase();

    if (diff.inMinutes < 60) {
      final minutes = diff.inMinutes < 1 ? 1 : diff.inMinutes;
      return '${minutes}m ago';
    }

    final isToday = now.year == local.year &&
        now.month == local.month &&
        now.day == local.day;
    if (isToday) return timeStr();

    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = yesterday.year == local.year &&
        yesterday.month == local.month &&
        yesterday.day == local.day;
    if (isYesterday) return 'Yesterday ${timeStr()}';

    return '${DateFormat('dd-MM-yyyy').format(local)} ${timeStr()}';
  }

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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.notification.title,
                style: TextStyle(
                  fontWeight: widget.notification.isRead
                      ? FontWeight.normal
                      : FontWeight.bold,
                  color: AppThemeCustom.getNotificationItemStyle(context),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatNotificationTime(context, widget.notification.receivedAt),
              style: TextStyle(
                fontSize: 11,
                color: AppThemeCustom.getNotificationItemStyle(context),
              ),
            ),
          ],
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