import 'package:flutter/material.dart';

import 'pages/authstate.dart';
import 'pages/farmer_dashboard.dart';
import 'pages/home.dart';
import 'pages/market_listing.dart';
import 'pages/product_single.dart';
import 'pages/register_farmer.dart';
import 'pages/splash.dart';
import 'utils/transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/SplashPage':
        return MaterialPageRoute(
          builder: (context) => SplashWidget(),
        );

      case '/AuthPage':
        return slideAnimation(Auth());
// animation =
      //     CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
      case '/HomePage':
        return fadeAnimation(HomePage(args));

      case '/MarketListingPage':
        return fadeAnimation(MarketListingPage(args));

      case '/ProductInfoPage':
        return fadeAnimation(ProductInfo());

      case '/RegisterFarmerPage':
        return fadeAnimation(RegisterFarmerPage());

      case '/FarmerInfo':
        return fadeAnimation(FarmerDashboard(args));

      default:
        return MaterialPageRoute(
          builder: (context) => SplashWidget(),
        );
    }
  }
}
