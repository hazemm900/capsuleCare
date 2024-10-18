import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:flutter/material.dart';

// class NotificationServices {
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//         null,
//         [
//           NotificationChannel(
//             channelGroupKey: 'high_importance_channel',
//             channelKey: 'high_importance_channel',
//             channelName: 'Basic Notifications',
//             channelDescription: 'Notification Channel For Basic Test',
//             importance: NotificationImportance.Max,
//             channelShowBadge: true,
//             onlyAlertOnce: true,
//             playSound: true,
//             criticalAlerts: true,
//           )
//         ],
//         channelGroups: [
//           NotificationChannelGroup(
//               channelGroupkey: 'high_importance_channel_group',
//               channelGroupName: 'Group 1')
//         ],
//         debug: true);
//     await AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }
//       },
//     );
//     await AwesomeNotifications().setListeners(
//         onActionRecivedMethod: onActionRecivedMethod,
//         onNotificationCreateMethod: onNotificationCreateMethod,
//         onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//         onDismissActionRecivedMethod: onDismissActionRecivedMethod);
//   }
//
//   static Future<void> onNotificationCreateMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationCreateMethod');
//   }
//
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onNotificationDisplayedMethod');
//   }
//
//   static Future<void> onDismissActionRecivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onDismissActionRecivedMethod');
//   }
//
//   static Future<void> onActionRecivedMethod(
//       ReceivedNotification receivedNotification) async {
//     debugPrint('onActionRecivedMethod');
//     final payload = receivedNotification.payload ?? {};
//     if (payload['navigate'] == "true") {
//       MainApp.navigatorKey.crruentState?.push(
//         MaterialPageRoute(
//           builder: (_) => const TestNavigationBottom(),
//         ),
//       );
//     }
//   }
//
//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? summary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval,
//   }) async {
//     assert(!scheduled || (scheduled && interval != null));
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: -1,
//         channelKey: 'high_importance_channel',
//         title: title,
//         body: body,
//         actionType: actionType,
//         notificationLayout: notificationLayout,
//         summary: summary,
//         category: category,
//         payload: payload,
//         bigPicture: bigPicture,
//       ),
//       actionButtons: actionButtons,
//       schedule: scheduled
//           ? NotificationInterval(
//               interval: interval,
//               timeZone:
//                   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//               preciseAlarm: true,
//             )
//           : null,
//     );
//   }
// }
