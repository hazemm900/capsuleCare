import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capsule_care/business_layer/add_new_medicine/add_new_medicine_cubit.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/localProvider.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/services/notifiService.dart';
import 'package:capsule_care/theme/theme_constants.dart';
import 'package:capsule_care/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'business_layer/navigation/navigation_bar_cubit.dart';
import 'core/bloc_observer/bloc_observer.dart';

// Helper function to generate unique notification IDs
int _generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  if (await Permission.notification.request().isGranted) {
    NotificationService notificationService = NotificationService();
    await notificationService.iniNotification();

    AwesomeNotifications().initialize(
      'resource://drawable/capsule_care',
      [
        NotificationChannel(
          channelKey: "basic_key",
          channelName: "Test Channel",
          channelDescription: "Notification for test",
          playSound: true,
          channelShowBadge: true,
          importance: NotificationImportance.Max,
          criticalAlerts: true,
          defaultPrivacy: NotificationPrivacy.Public,
        ),
        NotificationChannel(
          channelKey: "medicine_channel_test",
          channelName: "Schedule Channel",
          channelDescription: "Scheduled notification for medicines",
          playSound: true,
          channelShowBadge: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/iphone_alarm',
        )
      ],
    );

    AwesomeNotifications().actionStream.listen((receivedNotification) {
      int notificationId = receivedNotification.id ??
          _generateUniqueId(); // Provide a fallback ID if null

      if (receivedNotification.buttonKeyPressed == 'TAKE_MEDICINE') {
        print('User chose to take the medicine');

        int? medicineId =
            receivedNotification.id; // Ensure this maps to your medicine ID

        if (medicineId != null) {
          // Decrement the capsule count for this medicine
          SQDataBase().decrementCapsuleCount(medicineId);
        }

        // Use the navigatorKey to navigate
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const TestNavigationBottom()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      } else if (receivedNotification.buttonKeyPressed == 'SNOOZE') {
        print('User snoozed the reminder');

        // Generate a unique ID for the snoozed notification
        int newId = _generateUniqueId();

        // Create a new notification with a delay (e.g., 10 minutes)
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            channelKey: 'medicine_channel_test',
            id: newId,
            // Use the generated unique ID
            title: receivedNotification.title,
            body: receivedNotification.body,
            notificationLayout: NotificationLayout.Default,
          ),
          schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(Duration(minutes: 10)), // 10-minute delay
          ),
        );
      } else if (receivedNotification.buttonKeyPressed == 'TAKE_LATER') {
        String userInput = receivedNotification.buttonKeyInput;
        print('User input for take later: $userInput');
        // Handle user input and schedule a new notification based on input
      }
    });
  } else {
    // Show alert if permission is denied
    runApp(PermissionDeniedApp());
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        // LocaleProvider added
      ],
      child: const MyApp(),
    ),
  );
}

// Show an app with an alert when permission is denied
class PermissionDeniedApp extends StatelessWidget {
  const PermissionDeniedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Permission Denied')),
        body: Center(
          child: AlertDialog(
            title: Text('Permission Denied'),
            content: Text(
                'Notification permission is required for the app to function correctly. Please enable it in settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to update capsule count
void updateCapsuleCount(int notificationId, int decrementValue) {
  // Logic to update the capsule count in your database or state management system
  print(
      'Updating capsule count for notification ID $notificationId by $decrementValue');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider<NavigationBarCubit>(
        create: (BuildContext context) => NavigationBarCubit(),
      ),
      BlocProvider<AddNewMedicineCubit>(
        create: (BuildContext context) => AddNewMedicineCubit(),
      ),
    ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<LocaleProvider>(
            builder: (context, localeProvider, child) {
              return Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    locale: localeProvider.locale,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    theme: lightTheme,
                    // Default light theme
                    darkTheme: darkTheme,
                    // Custom dark theme
                    themeMode: themeProvider.themeMode,
                    // Apply theme mode
                    home: TestNavigationBottom(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
