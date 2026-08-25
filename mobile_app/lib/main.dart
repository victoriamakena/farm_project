import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav.dart';

// services
import 'services/products_service.dart';
import 'services/auth_service.dart';
import 'services/order_service.dart';
import '../services/cart_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>ProductsService(),
        ), 
        ChangeNotifierProvider(
          create: (_) =>AuthService(),
        ),
         ChangeNotifierProvider(
          create: (_) =>OrdersService(),
        ),
        ChangeNotifierProvider(
          create: (_) =>CartService(),
        ),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

