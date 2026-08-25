import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget{
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
        return Text('Checkout');  
  }
}