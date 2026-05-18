import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_pay/src/constant/uni_text.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/uni_pay.dart';

import '../../constant/path.dart';
import '../../core/controllers/uni_pay_controller.dart';
import '../../theme/colors.dart';

class PaymentResultView extends StatefulWidget {
  const PaymentResultView({Key? key, required this.paymentMethod})
      : super(key: key);

  // Payment method used
  final UniPayPaymentMethods paymentMethod;

  @override
  State<PaymentResultView> createState() => _PaymentResultViewState();
}

class _PaymentResultViewState extends State<PaymentResultView> {
  @override
  void initState() {
    super.initState();
    _setLottieImage();
  }

  LottieComposition? lottieComposition;

//* Loading lottie file
  void _setLottieImage() async {
    AssetLottie assetLottie = AssetLottie(
      UniPayControllers.uniPayStatus.isSuccess
          ? UniAssetsPath.success
          : UniAssetsPath.failed,
      package: UniAssetsPath.packageName,
    );
    lottieComposition = await assetLottie.load();
    setState(() {});
  }

  String getPaymentStatusTitle() {
    final status = UniPayControllers.uniPayStatus;
    if (status.isCancelled) {
      return UniPayText.paymentCancelled;
    } else if (status.isFailed && widget.paymentMethod.isTabby) {
      return UniPayText.paymentFailedByTabby;
    } else if (status.isFailed && widget.paymentMethod.isTamara) {
      return UniPayText.paymentFailedByTamara;
    } else if (status.isFailed) {
      return UniPayText.paymentFailed;
    } else {
      return UniPayText.paymentSuccessful;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UniPayDesignSystem.appBar(
          leading: Container(),
          title: UniPayText.paymentStatus,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* Icon
            SizedBox(
              width: 100.w,
              height: 30.h,
              child: lottieComposition != null
                  ? Lottie(composition: lottieComposition)
                  : const CircularProgressIndicator.adaptive(),
            ),
            //* Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.rw),
              child: Text(
                getPaymentStatusTitle(),
                style: UniPayTheme.uniPayStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),

            //* Subtitle
          ],
        ));
  }
}
