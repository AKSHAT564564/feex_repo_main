import 'package:feex/constants.dart';
import 'package:feex/providers/all_categories_provider.dart';
import 'package:feex/providers/customer_address_provider.dart';
import 'package:feex/providers/services_detail_provider.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/providers/top_services_provider.dart';
import 'package:feex/routes.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'size_config.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopServicesProvider>(
            create: (_) =>
                TopServicesProvider()), // provides top services on the home page
        ChangeNotifierProvider<CustomerDetailsProvider>(
            create: (_) =>
                CustomerDetailsProvider()), // provides customer details
        ChangeNotifierProvider<ServiceDetailProvider>(
            create: (_) =>
                ServiceDetailProvider()), //provides particular service detail based on the category
        ChangeNotifierProvider<CustomerAddressProvider>(
            create: (_) => CustomerAddressProvider()),
        ChangeNotifierProvider<AllCategoriesAndServiceProvider>(
            create: (_) =>
                AllCategoriesAndServiceProvider()) //provides customer addresses
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            hintColor: lightBlueColor,
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: kPrimaryColor),
              bodyText2: TextStyle(color: kSecondaryColor),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
