// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart' as payTab;
// import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
// import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
// import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutterwave_standard/core/flutterwave.dart';
// import 'package:flutterwave_standard/models/requests/customer.dart';
// import 'package:flutterwave_standard/models/requests/customizations.dart';
// import 'package:flutterwave_standard/models/responses/charge_response.dart';
// import 'package:flutterwave_standard/view/view_utils.dart';
// import 'package:http/http.dart' as http;
// import '../components/app_bar_components.dart';
// import '../extensions/colors.dart';
// import '../extensions/extension_util/int_extensions.dart';
// import '../extensions/extension_util/string_extensions.dart';
// import '../extensions/extension_util/widget_extensions.dart';
// import '../utils/images.dart';
// import 'package:my_fatoorah/my_fatoorah.dart';
// import 'package:paytm/paytm.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../components/payment_success_dialouge.dart';
// import '../extensions/LiveStream.dart';
// import '../extensions/animatedList/animated_list_view.dart';
// import '../extensions/app_button.dart';
// import '../extensions/common.dart';
// import '../extensions/decorations.dart';
// import '../extensions/loader_widget.dart';
// import '../extensions/shared_pref.dart';
// import '../extensions/system_utils.dart';
// import '../extensions/text_styles.dart';
// import '../main.dart';
// import '../models/payment_list_model.dart';
// import '../models/stripe_pay_model.dart';
// import '../network/RestApis.dart';
// import '../network/network_utills.dart';
// import '../utils/app_common.dart';
// import '../utils/app_config.dart';
// import '../utils/colors.dart';
// import '../utils/constants.dart';
// import 'no_data_screen.dart';

// class PaymentScreen extends StatefulWidget {
//   final int? id;
//   final num? price;
//   final bool? isFromLimit;

//   PaymentScreen({super.key, this.id, this.price, this.isFromLimit});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   List<PaymentModel> paymentList = [];

//   String? selectedPaymentType,
//       stripPaymentKey,
//       stripPaymentPublishKey,
//       payStackPublicKey,
//       payPalTokenizationKey,
//       flutterWavePublicKey,
//       flutterWaveSecretKey,
//       flutterWaveEncryptionKey,
//       payTabsProfileId,
//       payTabsServerKey,
//       payTabsClientKey,
//       myFatoorahToken,
//       paytmMerchantId,
//       orangeMoneyPublicKey,
//       paytmMerchantKey;

//   String? razorKey;

//   bool isPaytmTestType = true;
//   bool isFatrooahTestType = true;
//   bool loading = false;

//   final plugin = PaystackPlugin();

//   late Razorpay _razorpay;

//   CheckoutMethod method = CheckoutMethod.card;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   void init() async {
//     await paymentListApiCall();
//     if (paymentList.any((element) => element.type == PAYMENT_TYPE_STRIPE)) {
//       Stripe.publishableKey = stripPaymentPublishKey.validate();
//       Stripe.merchantIdentifier = mStripeIdentifier;
//       await Stripe.instance.applySettings().catchError((e) {
//         log("${e.toString()}");
//       });
//     }
//     if (paymentList.any((element) => element.type == PAYMENT_TYPE_PAYSTACK)) {
//       if (payStackPublicKey != null) {
//         plugin.initialize(publicKey: payStackPublicKey.validate());
//       }
//     }
//     if (paymentList.any((element) => element.type == PAYMENT_TYPE_RAZORPAY)) {
//       _razorpay = Razorpay();
//       _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//       _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//       _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     }
//   }

//   /// Get Payment Gateway Api Call
//   Future<void> paymentListApiCall() async {
//     appStore.setLoading(true);
//     await getPaymentApi().then((value) {
//       appStore.setLoading(false);

//       paymentList.addAll(value.data!);

//       if (paymentList.isNotEmpty) {
//         paymentList.forEach((element) {
//           setState(() {});

//           if (paymentList.isNotEmpty) {
//             if (element.type == PAYMENT_TYPE_STRIPE) {
//               stripPaymentKey = element.isTest == 1 ? element.testValue!.secretKey : element.liveValue!.secretKey;
//               stripPaymentPublishKey = element.isTest == 1 ? element.testValue!.publishableKey : element.liveValue!.publishableKey;
//             } else if (element.type == PAYMENT_TYPE_PAYSTACK) {
//               payStackPublicKey = element.isTest == 1 ? element.testValue!.publicKey : element.liveValue!.publicKey;
//             } else if (element.type == PAYMENT_TYPE_RAZORPAY) {
//               razorKey = element.isTest == 1 ? element.testValue!.keyId.validate() : element.liveValue!.keyId.validate();
//             } else if (element.type == PAYMENT_TYPE_PAYPAL) {
//               payPalTokenizationKey = element.isTest == 1 ? element.testValue!.tokenizationKey : element.liveValue!.tokenizationKey;
//             } else if (element.type == PAYMENT_TYPE_FLUTTERWAVE) {
//               flutterWavePublicKey = element.isTest == 1 ? element.testValue!.publicKey : element.liveValue!.publicKey;
//               flutterWaveSecretKey = element.isTest == 1 ? element.testValue!.secretKey : element.liveValue!.secretKey;
//               flutterWaveEncryptionKey = element.isTest == 1 ? element.testValue!.encryptionKey : element.liveValue!.encryptionKey;
//             } else if (element.type == PAYMENT_TYPE_PAYTABS) {
//               payTabsProfileId = element.isTest == 1 ? element.testValue!.profileId : element.liveValue!.profileId;
//               payTabsClientKey = element.isTest == 1 ? element.testValue!.clientKey : element.liveValue!.clientKey;
//               payTabsServerKey = element.isTest == 1 ? element.testValue!.serverKey : element.liveValue!.serverKey;
//             } else if (element.type == PAYMENT_TYPE_MYFATOORAH) {
//               if (element.isTest == 1) {
//                 isFatrooahTestType = true;
//               } else {
//                 isFatrooahTestType = false;
//               }
//               myFatoorahToken = element.isTest == 1 ? element.testValue!.accessToken : element.liveValue!.accessToken;
//             } else if (element.type == PAYMENT_TYPE_PAYTM) {
//               if (element.isTest == 1) {
//                 isPaytmTestType = true;
//               } else {
//                 isPaytmTestType = false;
//               }
//               paytmMerchantId = element.isTest == 1 ? element.testValue!.merchantId : element.liveValue!.merchantId;
//               paytmMerchantKey = element.isTest == 1 ? element.testValue!.merchantKey : element.liveValue!.merchantKey;
//             } else if (element.type == PAYMENT_TYPE_ORANGE_MONEY) {
//               orangeMoneyPublicKey = element.isTest == 1 ? element.testValue!.publicKey : element.liveValue!.publicKey;
//             }
//           }

//           setState(() {});
//           // }
//         });
//       }
//       setState(() {});
//     }).catchError((error) {
//       appStore.setLoading(false);
//       log("====>" + '${error.toString()}');
//     });
//   }

//   /// My Fatoorah Payment
//   Future<void> myFatoorahPayment() async {
//     PaymentResponse response = await MyFatoorah.startPayment(
//       context: context,
//       successChild: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.verified, size: 50, color: Colors.green),
//           16.height,
//           Text(language.success, style: boldTextStyle(color: Colors.green, size: 24)),
//         ],
//       ).center(),
//       errorChild: Center(child: Text(language.failed, style: boldTextStyle(color: Colors.red, size: 24))),
//       request: isFatrooahTestType
//           ? MyfatoorahRequest.test(
//               currencyIso: Country.SaudiArabia,
//               successUrl: 'https://pub.dev/packages/get',
//               errorUrl: 'https://www.google.com/',
//               invoiceAmount: widget.price.toString().validate().toDouble(),
//               language: appStore.selectedLanguage == 'ar' ? ApiLanguage.Arabic : ApiLanguage.English,
//               token: myFatoorahToken!,
//             )
//           : MyfatoorahRequest.live(
//               currencyIso: Country.SaudiArabia,
//               successUrl: 'https://pub.dev/packages/get',
//               errorUrl: 'https://www.google.com/',
//               invoiceAmount: widget.price.toString().validate().toDouble(),
//               language: appStore.selectedLanguage == 'ar' ? ApiLanguage.Arabic : ApiLanguage.English,
//               token: myFatoorahToken!,
//             ),
//     );
//     if (response.isSuccess) {
//       paymentConfirm();
//     } else if (response.isError) {
//       toast(language.paymentFailed);
//     }
//   }

//   /// Razor Pay
//   void razorPayPayment() {
//     var options = {
//       'key': razorKey.validate(),
//       'amount': (widget.price!.toDouble() * 100).toInt(),
//       'name': APP_NAME,
//       'description': mRazorDescription,
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': getStringAsync(CONTACT_NUMBER),
//         'email': getStringAsync(EMAIL),
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       log(e.toString());
//       debugPrint('Error: e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     toast(language.success);
//     paymentConfirm();
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     toast("ERROR: " + response.code.toString() + " - " + response.message!);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     toast("EXTERNAL_WALLET: " + response.walletName!);
//   }

//   /// StripPayment
//   void stripePay() async {
//     Map<String, String> headers = {
//       HttpHeaders.authorizationHeader: 'Bearer ${stripPaymentKey.validate()}',
//       HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
//     };

//     var request = http.Request('POST', Uri.parse(stripeURL));

//     request.bodyFields = {
//       'amount': '${(widget.price!.toDouble() * 100).toInt()}',
//       'currency': "${userStore.currencyCode.toUpperCase()}",
//     };

//     log(request.bodyFields);
//     request.headers.addAll(headers);

//     log(request);

//     appStore.setLoading(true);

//     await request.send().then((value) {
//       http.Response.fromStream(value).then((response) async {
//         if (response.statusCode == 200) {
//           var res = StripePayModel.fromJson(await handleResponse(response));

//           SetupPaymentSheetParameters setupPaymentSheetParameters = SetupPaymentSheetParameters(
//             paymentIntentClientSecret: res.clientSecret.validate(),
//             style: ThemeMode.light,
//             appearance: PaymentSheetAppearance(colors: PaymentSheetAppearanceColors(primary: primaryColor)),
//             applePay: PaymentSheetApplePay(merchantCountryCode: "${userStore.currencySymbol.toUpperCase()}"),
//             googlePay: PaymentSheetGooglePay(merchantCountryCode: "${userStore.currencySymbol.toUpperCase()}", testEnv: true),
//             merchantDisplayName: APP_NAME,
//             customerId: userStore.userId.toString(),
//           );

//           await Stripe.instance.initPaymentSheet(paymentSheetParameters: setupPaymentSheetParameters).then((value) async {
//             await Stripe.instance.presentPaymentSheet().then((value) async {
//               paymentConfirm();
//             });
//           }).catchError((e) {
//             log("presentPaymentSheet ${e.toString()}");
//           });
//         }
//         appStore.setLoading(false);
//       }).catchError((e) {
//         appStore.setLoading(false);
//         toast(e.toString());
//       });
//     }).catchError((e) {
//       appStore.setLoading(false);
//       toast(e.toString());
//     });
//   }

//   ///PayStack Payment
//   void payStackPayment(BuildContext context) async {
//     appStore.setLoading(true);
//     Charge charge = Charge()
//       ..amount = (widget.price.toString().toDouble() * 100).toInt() // In base currency
//       ..email = userStore.email.validate()
//       ..currency = userStore.currencyCode.toUpperCase();
//     charge.reference = _getReference();

//     try {
//       CheckoutResponse response = await plugin.checkout(context, method: method, charge: charge, fullscreen: false);
//       payStackUpdateStatus(response.reference, response.message);
//       if (response.message == "Success") {
//         appStore.setLoading(false);
//         paymentConfirm();
//       } else {
//         appStore.setLoading(false);

//         toast(language.paymentFailed);
//       }
//     } catch (e) {
//       appStore.setLoading(false);
//       payStackShowMessage("Check console for error");
//       rethrow;
//     }
//   }

//   payStackUpdateStatus(String? reference, String message) {
//     payStackShowMessage(message, const Duration(seconds: 7));
//   }

//   void payStackShowMessage(String message, [Duration duration = const Duration(seconds: 4)]) {
//     toast(message);
//     log(message);
//   }

//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }
//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }

//   /// Paypal Payment
//   void payPalPayment() async {
//     appStore.setLoading(true);
//     final request = BraintreePayPalRequest(amount: widget.price.toString(), currencyCode: userStore.currencySymbol.toUpperCase(), displayName: userStore.username.validate());

//     final result = await Braintree.requestPaypalNonce(
//       payPalTokenizationKey!,
//       request,
//     );
//     if (result != null) {
//       appStore.setLoading(false);
//       paymentConfirm();
//     } else {
//       appStore.setLoading(false);
//     }
//   }

//   /// FlutterWave Payment
//   void flutterWaveCheckout() async {
//     appStore.setLoading(true);
//     final customer = Customer(name: userStore.username.validate(), phoneNumber: userStore.phoneNo.validate(), email: userStore.email.validate());

//     final Flutterwave flutterwave = Flutterwave(
//       publicKey: flutterWavePublicKey.validate(),
//       currency: userStore.currencySymbol.validate().toLowerCase(),
//       redirectUrl: "https://www.google.com",
//       txRef: DateTime.now().millisecond.toString(),
//       amount: widget.price.toString(),
//       customer: customer,
//       paymentOptions: "card, payattitude",
//       customization: Customization(title: "Test Payment"),
//       isTestMode: isPaytmTestType,
//     );
//     final ChargeResponse response = await flutterwave.charge(context);
//     if (response.status == 'successful') {
//       appStore.setLoading(false);
//       paymentConfirm();
//       print("${response.toJson()}");
//     } else {
//       appStore.setLoading(false);
//       FlutterwaveViewUtils.showToast(context, "Transaction Failed");
//     }
//   }

//   /// PayTabs Payment
//   void payTabsPayment() {
//     appStore.setLoading(true);
//     FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
//       setState(() {
//         if (event["status"] == "success") {
//           var transactionDetails = event["data"];
//           if (transactionDetails["isSuccess"]) {
//             toast(language.transactionSuccessful);
//             paymentConfirm();
//           } else {
//             toast(language.transactionFailed);
//           }
//           toast(language.transactionSuccessful);
//         } else if (event["status"] == "error") {
//           print("error");
//         } else if (event["status"] == "event") {
//           //
//         }
//         appStore.setLoading(false);
//       });
//     });
//   }

//   PaymentSdkConfigurationDetails generateConfig() {
//     List<PaymentSdkAPms> apms = [];
//     apms.add(PaymentSdkAPms.STC_PAY);
//     var configuration = PaymentSdkConfigurationDetails(
//         profileId: payTabsProfileId,
//         serverKey: payTabsServerKey,
//         clientKey: payTabsClientKey,
//         screentTitle: language.payWithCard,
//         amount: widget.price!.toDouble(),
//         showBillingInfo: true,
//         forceShippingInfo: false,
//         currencyCode: userStore.currencySymbol.toUpperCase(),
//         merchantCountryCode: userStore.currencySymbol.toUpperCase(),
//         billingDetails: payTab.BillingDetails(
//           userStore.username.validate(),
//           userStore.email.validate(),
//           userStore.phoneNo.validate(),
//           '',
//           '',
//           '',
//           '',
//           '',
//         ),
//         alternativePaymentMethods: apms,
//         linkBillingNameWithCardHolderName: true);

//     var theme = IOSThemeConfigurations();

//     theme.logoImage = ic_logo;

//     configuration.iOSThemeConfigurations = theme;

//     return configuration;
//   }

//   /// PayTm Payment
//   void paytmPayment() async {
//     appStore.setLoading(true);
//     String orderId = DateTime.now().millisecondsSinceEpoch.toString();

//     String callBackUrl = (isPaytmTestType ? 'https://securegw-stage.paytm.in' : 'https://securegw.paytm.in') + '/theia/paytmCallback?ORDER_ID=' + orderId;

//     var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

//     var body = json.encode({
//       "mid": paytmMerchantId,
//       "key_secret": paytmMerchantKey,
//       "website": isPaytmTestType ? "WEBSTAGING" : "DEFAULT",
//       "orderId": orderId,
//       "amount": widget.price.toString(),
//       "callbackUrl": callBackUrl,
//       "custId": userStore.userId,
//       "testing": isPaytmTestType ? 0 : 1
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: body,
//         headers: {'Content-type': "application/json"},
//       );

//       String txnToken = response.body;

//       var paytmResponse = Paytm.payWithPaytm(
//         mId: paytmMerchantId!,
//         orderId: orderId,
//         txnToken: txnToken,
//         txnAmount: widget.price.toString(),
//         callBackUrl: callBackUrl,
//         staging: isPaytmTestType,
//         appInvokeEnabled: false,
//       );

//       paytmResponse.then((value) {
//         setState(() {
//           loading = false;
//           if (value['error']) {
//             toast(value['errorMessage']);
//           } else {
//             if (value['response'] != null) {
//               toast(value['response']['RESPMSG']);
//               if (value['response']['STATUS'] == 'TXN_SUCCESS') {
//                 paymentConfirm();
//               }
//             }
//           }
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> paymentConfirm() async {
//     appStore.setLoading(true);
//     Map req = {widget.isFromLimit == true ? "extra_property_limit_id" : "package_id": widget.id, "payment_status": "paid", "payment_type": selectedPaymentType, "txn_id": "", "transaction_detail": ""};
//     widget.isFromLimit == true
//         ? await purchaseExtraLimitApi(req).then((value) {
//             getUSerDetail(context, userStore.userId).then((value) {
//               setState(() {
//                 appStore.setLoading(false);
//                 LiveStream().emit(PAYMENT);
//                 finish(context);
//                 finish(context);
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return PaymentSuccessDialog(
//                       () {},
//                     );
//                   },
//                 );
//               });
//             });
//           })
//         : await subscribePackageApi(req).then((value) async {
//             getUSerDetail(context, userStore.userId).then((value) {
//               setState(() {
//                 appStore.setLoading(false);
//                 LiveStream().emit(PAYMENT);
//                 finish(context);
//                 finish(context);
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return PaymentSuccessDialog(
//                       () {},
//                     );
//                   },
//                 );
//               });
//             });
//           }).catchError((e) {
//             appStore.setLoading(false);
//             print(e.toString());
//           });
//     appStore.setLoading(false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.light,
//         systemNavigationBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.light,
//       ),
//       child: Scaffold(
//         appBar: appBarWidget(language.payments, context1: context, titleSpace: 0),
//         body: Stack(
//           children: [
//             paymentList.isNotEmpty
//                 ? AnimatedListView(
//                     shrinkWrap: true,
//                     itemCount: paymentList.length,
//                     padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
//                         margin: EdgeInsets.only(bottom: 16),
//                         decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset(selectedPaymentType == paymentList[index].type ? ic_radio_fill : ic_radio, height: 24, width: 24),
//                             10.width,
//                             Row(
//                               children: [
//                                 cachedImage(paymentList[index].gatewayImage!, width: 45, height: 45, fit: BoxFit.contain),
//                                 12.width,
//                                 Text(paymentList[index].title.validate().capitalizeFirstLetter(), style: primaryTextStyle(), maxLines: 2),
//                               ],
//                             ).expand(),
//                           ],
//                         ),
//                       ).onTap(() {
//                         selectedPaymentType = paymentList[index].type;
//                         setState(() {});
//                       });
//                     })
//                 : NoDataScreen().visible(!appStore.isLoading),
//             Observer(
//               builder: (context) {
//                 return Loader().center().visible(appStore.isLoading);
//               },
//             )
//           ],
//         ),
//         bottomNavigationBar: Padding(
//           padding: EdgeInsets.all(16),
//           child: Visibility(
//             visible: paymentList.isNotEmpty,
//             child: AppButton(
//               text: language.pay,
//               color: primaryColor,
//               onTap: () {
//                 if (selectedPaymentType == PAYMENT_TYPE_RAZORPAY) {
//                   razorPayPayment();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_STRIPE) {
//                   stripePay();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_PAYSTACK) {
//                   payStackPayment(context);
//                 } else if (selectedPaymentType == PAYMENT_TYPE_PAYPAL) {
//                   payPalPayment();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_FLUTTERWAVE) {
//                   flutterWaveCheckout();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_PAYTABS) {
//                   payTabsPayment();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_PAYTM) {
//                   paytmPayment();
//                 } else if (selectedPaymentType == PAYMENT_TYPE_MYFATOORAH) {
//                   myFatoorahPayment();
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
