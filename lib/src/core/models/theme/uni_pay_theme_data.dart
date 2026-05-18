import 'package:flutter/material.dart';

import '../../../utils/uni_enums.dart';

/// Appearance and copy overrides for UniPay flows.
///
/// [themeMode] controls light/dark (and OS **system**) for the nested
/// UniPay [MaterialApp]. Defaults to following the device brightness.
///
/// [primaryColor] seeds the Flutter [ColorScheme] (brand primary).
class UniPayThemeData {
  /// Primary brand color — used as seed for light/dark [ColorScheme].
  final Color primaryColor;

  /// How the nested UniPay [MaterialApp] resolves light vs dark.
  ///
  /// Use [ThemeMode.system] to follow the host OS (default).
  final ThemeMode themeMode;

  /// UI type for the payment view
  final UniPayUIType uiType;

  /// Header Title text
  final String? headerTitle;

  /// Header Subtitle text
  final String? headerSubtitle;

  /// App bar text
  final String? appBarTitle;

  /// Tabby header title text
  final String? tabbyHeaderTitle;

  /// Tamara header title text
  final String? tamaraHeaderTitle;

  /// Credit card header title text
  final String? creditCardHeaderTitle;

  UniPayThemeData({
    this.primaryColor = const Color(0xffEE174B),
    this.themeMode = ThemeMode.system,
    this.uiType = UniPayUIType.modern,
    this.headerTitle,
    this.headerSubtitle,
    this.appBarTitle,
    this.tabbyHeaderTitle,
    this.tamaraHeaderTitle,
    this.creditCardHeaderTitle,
  });
}
