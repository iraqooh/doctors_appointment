import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsController {
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod (
      ReceivedNotification receivedNotification
      ) async {

  }

  @pragma('vm-entry-point')
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification
      ) async {

  }

  @pragma('vm-entry-point')
  static Future<void> onDismissActionReceivedMethod(
      ReceivedNotification receivedAction
      ) async {

  }

  @pragma('vm-entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedAction
      ) async {

  }
}