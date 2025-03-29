import 'package:api_crud_app/Provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'App.dart';
import 'Provider/product_cart_provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(),),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ));


// This Code for DevicePreview : =>

// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
// void main() => runApp(DevicePreview(
//     backgroundColor: Colors.black12,
//     enabled: !kReleaseMode,
//     builder: (context) => const MyApp()));