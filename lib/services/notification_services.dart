import 'package:hive_flutter/hive_flutter.dart';
import 'package:qantum_apps/data/models/notification_model.dart';

/// Simple wrapper around a single Hive box that stores ALL users'
/// notifications together. We filter by userId at read time instead of
/// using separate boxes per user - simpler to manage.
class NotificationHiveService {
  static const String boxName = 'notificationsBox';

  static Box<NotificationModel>? _box;

  /// Call this once, early in main() before runApp(), after Hive.initFlutter().
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    _box = await Hive.openBox<NotificationModel>(boxName);
    print('[NotificationHive] box opened, total records: ${_box!.length}');
  }

  static Box<NotificationModel> get _safeBox {
    if (_box == null) {
      throw Exception(
          'NotificationHiveService.init() not called before use');
    }
    return _box!;
  }

  /// Save a new notification (called from foreground willDisplay listener,
  /// or from click listener if it wasn't already saved).
  static Future<void> save(NotificationModel model) async {
    final existing = _safeBox.get(model.id);
    if (existing != null) {
      print('[NotificationHive] duplicate id=${model.id}, skipping save');
      return;
    }
    await _safeBox.put(model.id, model);
    print(
        '[NotificationHive] SAVED id=${model.id} userId=${model.userId} title="${model.title}" isRead=${model.isRead}');
  }

  /// Mark a notification as read by its id. If it doesn't exist yet
  /// (e.g. notification arrived in background/terminated and this is the
  /// first time we're seeing it via tap), create it directly as read.
  static Future<void> markAsRead({
    required String id,
    required String userId,
    required String title,
    required String body,
    String? imageUrl,
    String? payload,
  }) async {
    final existing = _safeBox.get(id);
    if (existing != null) {
      existing.isRead = true;
      await existing.save();
      print('[NotificationHive] MARKED READ id=$id');
    } else {
      final model = NotificationModel(
        id: id,
        userId: userId,
        title: title,
        body: body,
        imageUrl: imageUrl,
        payload: payload,
        isRead: true,
        receivedAt: DateTime.now(),
      );
      await _safeBox.put(id, model);
      print(
          '[NotificationHive] CREATED FROM TAP (was background/terminated) id=$id, isRead=true');
    }
  }

  /// Returns all notifications belonging to a specific userId,
  /// most recent first.
  static List<NotificationModel> getForUser(String userId) {
    final list = _safeBox.values.where((n) => n.userId == userId).toList();
    list.sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
    print(
        '[NotificationHive] getForUser($userId) -> ${list.length} records');
    return list;
  }

  static int unreadCountForUser(String userId) {
    return _safeBox.values
        .where((n) => n.userId == userId && !n.isRead)
        .length;
  }

  /// Optional: call this on logout if you ever want to wipe local data
  /// for the current user. Not required for the "show only current user's
  /// notifications" requirement - filtering in getForUser() is enough.
  static Future<void> clearForUser(String userId) async {
    final keys = _safeBox.values
        .where((n) => n.userId == userId)
        .map((n) => n.id)
        .toList();
    await _safeBox.deleteAll(keys);
    print('[NotificationHive] cleared ${keys.length} records for $userId');
  }
}