import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/auth/register.dart';
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Cartprovider(),
        child: Builder( builder: (BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        home:product_list(),
      );

    }),
);
}
}

