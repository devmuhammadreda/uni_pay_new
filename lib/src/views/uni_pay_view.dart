import 'package:flutter/material.dart';

import '../constant/locale.dart';
import '../constant/uni_text.dart';
import '../core/controllers/uni_pay_controller.dart';
import '../core/models/uni_pay_data.dart';
import '../theme/colors.dart';
import 'uni_nav_keys.dart';
import 'widgets/uni_pay_view_handler.dart';

class UniPay extends StatefulWidget {
  ///* Provide the context of the app
  final BuildContext context;

  ///* Uni Pay Data to be used for payment request
  final UniPayData uniPayData;

  /// Child widget to be displayed in the UniPay view under the payment options
  final Widget? child;

  const UniPay({
    Key? key,
    required this.context,
    required this.uniPayData,
    this.child,
  }) : super(key: key);

  @override
  State<UniPay> createState() => _UniPayState();
}

class _UniPayState extends State<UniPay> {
  @override
  void initState() {
    super.initState();
    UniPayControllers.setUniPayData(widget.uniPayData, widget.context);
  }

  @override
  Widget build(BuildContext context) {
    final uniPayData = widget.uniPayData;
    final themeData = uniPayData.uniPayThemeData;
    UniPayText.isEnglish = uniPayData.locale.isEnglish;

    return MaterialApp(
      navigatorKey: uniStateKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: LocalizationsData.localizationsDelegate,
      supportedLocales: LocalizationsData.supportLocale,
      theme: UniPayTheme.themeFor(themeData, Brightness.light),
      darkTheme: UniPayTheme.themeFor(themeData, Brightness.dark),
      themeMode: themeData.themeMode,
      locale: uniPayData.locale.currentLocale,
      home: UniPayViewHandler(child: widget.child),
    );
  }
}
