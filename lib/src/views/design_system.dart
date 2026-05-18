import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uni_pay/src/constant/path.dart';
import 'package:uni_pay/src/core/controllers/uni_pay_controller.dart';
import 'package:uni_pay/src/theme/colors.dart';
import 'package:uni_pay/src/utils/extension.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/uni_nav_keys.dart';

import '../constant/uni_text.dart';

class UniPayDesignSystem {
  UniPayDesignSystem._();

  ///* Appbar for UniPay
  static AppBar appBar(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget> actions = const [],
    PreferredSizeWidget? bottom,
    bool isFromRoot = false,
    bool isShowBackButton = true,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return AppBar(
      elevation: 0,
      leading: Visibility(
        visible: isShowBackButton,
        child: leading ??
            BackButton(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.all<double>(18.rSp),
              ),
              color: scheme.onSurface,
              onPressed: () {
                if (isFromRoot) {
                  UniPayControllers.context.uniPop();
                } else {
                  uniStateKey.currentContext?.uniPop();
                }
              },
            ),
      ),
      flexibleSpace: GlassMorphism(
        sigmaVal: 5,
        child: Container(color: Colors.transparent),
      ),
      backgroundColor: scheme.surface.withAlpha(100),
      title: Text(
        title,
        style: UniPayTheme.uniPayStyle(context).copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 16.rSp,
        ),
      ),
      actions: actions,
      centerTitle: true,
      bottom: bottom,
    );
  }

  ///* Loading Indicator
  static Widget loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3.rSp,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      );

  ///* Error View
  static Widget errorView(
    BuildContext context, {
    String? title,
    dynamic subTitle,
  }) =>
      Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? UniPayText.somethingWentWrong,
              style: UniPayTheme.uniPayStyle(context),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              10.vs,
              Text(
                subTitle.toString(),
                textAlign: TextAlign.center,
                style: UniPayTheme.uniPayStyle(context).copyWith(
                  color: context.uniPayTokens.greyText,
                ),
              )
            ]
          ],
        ),
      );

  ///* Radio button checkbox
  static Widget checkBox(
    BuildContext context, {
    required bool status,
    ValueChanged<bool>? onChange,
    required Color activeColor,
  }) =>
      Transform.scale(
        scale: 1.5,
        child: Checkbox(
          activeColor: activeColor,
          value: status,
          shape: const CircleBorder(),
          side: BorderSide(color: context.uniPayTokens.checkBoxSide),
          onChanged: (v) => onChange?.call(v ?? false),
          overlayColor:
              const WidgetStatePropertyAll<Color>(Colors.transparent),
        ),
      );

  ///* Primary button
  static Widget primaryButton(
    BuildContext context, {
    required String title,
    VoidCallback? onPressed,
    bool showLoading = false,
    bool isDisabled = false,
    double? width,
    double? height,
    double marginBottom = 0,
    bool isBottomBarButton = false,
    Color? backgroundColor,
    Widget? trailing,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final tokens = context.uniPayTokens;
    final bool isButtonDisabled = isDisabled || showLoading;
    final Color bgResolved = backgroundColor ?? scheme.primary;
    final Color onPrimary = scheme.onPrimary;
    return InkWell(
      onTap: isButtonDisabled ? null : onPressed,
      child: Container(
        width: width ?? 100.w,
        height: height ?? 50.rSp,
        margin: EdgeInsets.only(
            bottom: isBottomBarButton ? 25.rh : marginBottom),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isButtonDisabled
              ? tokens.fillColor
              : bgResolved,
          borderRadius: 10.br,
        ),
        child: Visibility(
          visible: showLoading,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2.rw,
            children: [
              Text(
                title,
                style: UniPayTheme.uniPayStyle(context).copyWith(
                  color: isButtonDisabled
                      ? tokens.greyText
                      : onPrimary,
                  fontSize: 14.rSp,
                ),
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          child: UniPayDesignSystem.loadingIndicator(context),
        ),
      ),
    );
  }

  /// Title and Subtitle Widget
  static Widget titleSubTitleWidget(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.rh,
        children: [
          Text(
            title,
            style: UniPayTheme.uniPayStyle(context).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.rSp,
            ),
          ),
          Text(
            subTitle,
            style: UniPayTheme.uniPaySubTitleStyle(context).copyWith(
              fontSize: 13.rSp,
            ),
          )
        ],
      );

  /// Image Icon
  static Widget imgIcon(
    String assetName, {
    BoxFit fit = BoxFit.contain,
    double? size,
    Color? color,
  }) =>
      Image.asset(
        assetName,
        fit: fit,
        width: size ?? 24.rSp,
        height: size ?? 24.rh,
        color: color,
        package: UniAssetsPath.packageName,
      );

  /// Default duration
  static Duration kDefaultDuration = const Duration(milliseconds: 300);

  ///* `Animated Cross Fade` Widget for switch child
  static Widget animatedCrossFadeWidget({
    required bool animationStatus,
    required Widget shownIfFalse,
    required Widget shownIfTrue,
    VoidCallback? onPressed,
    Duration? duration,
    Curve firstCurve = Curves.easeIn,
    Curve sizeCurve = Curves.easeInOut,
  }) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedCrossFade(
        firstChild: shownIfFalse,
        secondChild: shownIfTrue,
        crossFadeState: animationStatus
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: duration ?? kDefaultDuration,
        alignment: Alignment.center,
        firstCurve: firstCurve,
        sizeCurve: sizeCurve,
      ),
    );
  }
}

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double sigmaVal;
  const GlassMorphism({Key? key, required this.child, this.sigmaVal = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaVal, sigmaY: sigmaVal),
      child: child,
    ));
  }
}
