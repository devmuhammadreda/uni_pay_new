import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/core/models/theme/uni_pay_theme_data.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';

@immutable
class UniPayTokens extends ThemeExtension<UniPayTokens> {
  const UniPayTokens({
    required this.greyText,
    required this.fillColor,
    required this.cyan,
    required this.greyColor5,
    required this.grayTextColor,
    required this.greyColor3,
    required this.greyColor8,
    required this.secondaryText,
    required this.greyBorderColor,
    required this.boldGreyColor,
    required this.redColor,
    required this.checkBoxSide,
  });

  final Color greyText;
  final Color fillColor;
  final Color cyan;
  final Color greyColor5;
  final Color grayTextColor;
  final Color greyColor3;
  final Color greyColor8;
  final Color secondaryText;
  final Color greyBorderColor;
  final Color boldGreyColor;
  final Color redColor;
  final Color checkBoxSide;

  static UniPayTokens resolve(Brightness brightness, ColorScheme scheme) {
    if (brightness == Brightness.dark) {
      return UniPayTokens(
        greyText: const Color(0xFFB0B0B0),
        fillColor: const Color(0xFF2C2C2E),
        cyan: const Color(0xFF13ACDF),
        greyColor5: const Color(0xFF3A3A3E),
        grayTextColor: scheme.onSurface,
        greyColor3: const Color(0xFF9EA3AD),
        greyColor8: const Color(0xFF8E9399),
        secondaryText: scheme.onSurface,
        greyBorderColor: const Color(0xFF48484C),
        boldGreyColor: const Color(0xFFB8BECC),
        redColor: const Color(0xffFC4742),
        checkBoxSide: const Color(0xFF666666),
      );
    }
    return UniPayTokens(
      greyText: const Color(0xFF808080),
      fillColor: const Color(0xFFF5F5F5),
      cyan: const Color(0xFF13ACDF),
      greyColor5: const Color(0xffF1F2F3),
      grayTextColor: const Color(0xff25272A),
      greyColor3: const Color(0xff858B94),
      greyColor8: const Color(0xffA0A5AB),
      secondaryText: const Color(0xFF25272A),
      greyBorderColor: const Color(0xFFFAFAFA),
      boldGreyColor: const Color(0xff6B717A),
      redColor: const Color(0xffFC4742),
      checkBoxSide: Colors.grey.withValues(alpha: 0.45),
    );
  }

  @override
  UniPayTokens copyWith({
    Color? greyText,
    Color? fillColor,
    Color? cyan,
    Color? greyColor5,
    Color? grayTextColor,
    Color? greyColor3,
    Color? greyColor8,
    Color? secondaryText,
    Color? greyBorderColor,
    Color? boldGreyColor,
    Color? redColor,
    Color? checkBoxSide,
  }) {
    return UniPayTokens(
      greyText: greyText ?? this.greyText,
      fillColor: fillColor ?? this.fillColor,
      cyan: cyan ?? this.cyan,
      greyColor5: greyColor5 ?? this.greyColor5,
      grayTextColor: grayTextColor ?? this.grayTextColor,
      greyColor3: greyColor3 ?? this.greyColor3,
      greyColor8: greyColor8 ?? this.greyColor8,
      secondaryText: secondaryText ?? this.secondaryText,
      greyBorderColor: greyBorderColor ?? this.greyBorderColor,
      boldGreyColor: boldGreyColor ?? this.boldGreyColor,
      redColor: redColor ?? this.redColor,
      checkBoxSide: checkBoxSide ?? this.checkBoxSide,
    );
  }

  @override
  UniPayTokens lerp(ThemeExtension<UniPayTokens>? other, double t) {
    if (other is! UniPayTokens) return this;
    return UniPayTokens(
      greyText: Color.lerp(greyText, other.greyText, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      greyColor5: Color.lerp(greyColor5, other.greyColor5, t)!,
      grayTextColor: Color.lerp(grayTextColor, other.grayTextColor, t)!,
      greyColor3: Color.lerp(greyColor3, other.greyColor3, t)!,
      greyColor8: Color.lerp(greyColor8, other.greyColor8, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      greyBorderColor: Color.lerp(greyBorderColor, other.greyBorderColor, t)!,
      boldGreyColor: Color.lerp(boldGreyColor, other.boldGreyColor, t)!,
      redColor: Color.lerp(redColor, other.redColor, t)!,
      checkBoxSide: Color.lerp(checkBoxSide, other.checkBoxSide, t)!,
    );
  }
}

extension UniPayThemeContext on BuildContext {
  UniPayTokens get uniPayTokens {
    final theme = Theme.of(this);
    return theme.extension<UniPayTokens>() ??
        UniPayTokens.resolve(theme.brightness, theme.colorScheme);
  }
}

class UniPayTheme {
  UniPayTheme._();

  static String fontFamily = "IBMPlexSansArabic";

  static ThemeData themeFor(
    UniPayThemeData themeData,
    Brightness brightness,
  ) {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: themeData.primaryColor,
      brightness: brightness,
    ).copyWith(
      primary: themeData.primaryColor,
      onPrimary: _readableOn(themeData.primaryColor),
      surfaceTint: Colors.transparent,
    );
    final tokens = UniPayTokens.resolve(brightness, scheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: fontFamily,
      extensions: [tokens],
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }

  static Color _readableOn(Color background) =>
      background.computeLuminance() > 0.179 ? Colors.black87 : Colors.white;

  /// Primary body / title emphasis (inherits [ColorScheme.onSurface] unless overridden).
  static TextStyle uniPayStyle(BuildContext context) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle uniPaySubTitleStyle(BuildContext context) => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
        color: context.uniPayTokens.greyText,
      );

  static TextStyle defaultTitle500Style(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color ?? Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w500,
      fontSize: 14.rSp,
      fontFamily: fontFamily,
      package: UniAssetsPath.packageName,
    );
  }

  static TextStyle title13Style400(BuildContext context) => TextStyle(
        color: context.uniPayTokens.boldGreyColor,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: 13.rSp,
        package: UniAssetsPath.packageName,
      );
}
