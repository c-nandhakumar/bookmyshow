import 'package:bookmyshow/provider/theatreseat_provider.dart';
import 'package:bookmyshow/unused/theatresPage.dart';
import 'package:bookmyshow/provider/date_provider.dart';
import 'package:bookmyshow/provider/movielist_provider.dart';
import 'package:bookmyshow/provider/notification_provider.dart';
import 'package:bookmyshow/provider/orders_provider.dart';
import 'package:bookmyshow/provider/theatrelist_provider.dart';
import 'package:bookmyshow/provider/tickets_provider.dart';
import 'package:bookmyshow/widgets/palette.dart';
import 'package:flutter/material.dart';

import 'package:bookmyshow/loginpagevalidation/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import 'package:bookmyshow/LocaleString.dart';
import 'package:bookmyshow/provider/googlesignin_provider.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

// import 'dart:io';
import 'dart:async';

import 'bottomnavigation/bottomnavigator.dart';
import 'buzzpage/provider/buzz_provider.dart';
import 'landingpage/services/theatreseat_service.dart';
import 'loginpage/loginpage.dart';
import 'loginpage/splashscreen.dart';
import 'notifications/notification_page.dart';

const AndroidNotificationChannel channel =
    AndroidNotificationChannel('high_importance_channel', 'Grab Your Seats Now',
        // 'Book the tickets for PS-I',
        importance: Importance.high,
        playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHnadler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Notification : ${message.messageId}');
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHnadler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(BookMyShow());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class BookMyShow extends StatefulWidget {
  const BookMyShow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BookMyShowState();
  }
}

class BookMyShowState extends State<BookMyShow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // OneSignal.shared.setAppId("6c72e096-055c-4e9c-847e-8b79c6a8e65c");

    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   print("Accepted permission: $accepted");
    // });
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MovieList(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoogleSignInCubit(),
          ),
          ChangeNotifierProvider(
            create: (context) => TicketList(),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationList(),
          ),
          ChangeNotifierProvider(
            create: (context) => DatesProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrdersList(),
          ),
          ChangeNotifierProvider(
            create: (context) => TheatreList(),
          ),
          ChangeNotifierProvider(
            create: (context) => TheatreSeatsList(),
          ),
          ChangeNotifierProvider(
            create: (context) => BuzzProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TheatreSeatService(),
          )
        ],
        child: GetMaterialApp(
          translations: LocaleString(),

          locale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          initialRoute: "/splashscreen",
          routes: {
            "/splashscreen": (ctx) => const SplashScreen(),
            HomePage.routeName: (ctx) => const HomePage(),
            "/loginpage": (ctx) => MyApp(),
            "/bottomnavigation": (ctx) => const BottomNavigation(),
            TheatresPage.routeName: (ctx) => TheatresPage(),
          },
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 231, 48, 72),
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(color: Colors.white))),
              primaryColor: Color.fromARGB(255, 4, 28, 48),
              primarySwatch: Palette.kToDark),
          //supportedLocales: L10n.all,
        ),
      );
}
