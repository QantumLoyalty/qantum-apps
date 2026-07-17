import 'package:hive/hive.dart';

/// Hive model for a saved local notification.
///
/// typeId = 10 -> make sure this doesn't clash with any other
/// Hive TypeAdapter typeId already registered in qantum-apps.
/// grep for "typeId:" across the project before wiring this in.
class NotificationModel extends HiveObject {
  final String id; // OneSignal notificationId
  final String userId; // logged-in user this notification belongs to
  final String title;
  final String body;
  final String? imageUrl; // big picture / large icon url, if present
  final String? payload; // raw additionalData / launch url, stored as json string
  bool isRead;
  final DateTime receivedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.imageUrl,
    this.payload,
    this.isRead = false,
    required this.receivedAt,
  });
}

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 10;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      body: fields[3] as String,
      imageUrl: fields[4] as String?,
      payload: fields[5] as String?,
      isRead: fields[6] as bool,
      receivedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.payload)
      ..writeByte(6)
      ..write(obj.isRead)
      ..writeByte(7)
      ..write(obj.receivedAt);
  }
}