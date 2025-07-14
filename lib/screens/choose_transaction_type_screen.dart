import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:orex/components/transaction_type_card.dart';
import 'package:orex/extensions/colors.dart';
import 'package:orex/extensions/extension_util/widget_extensions.dart';
import 'package:orex/screens/dashboard_screen.dart';
import 'package:orex/screens/home_screen.dart';
import 'package:orex/utils/images.dart';
import '../components/app_bar_components.dart';
import '../extensions/loader_widget.dart';
import '../extensions/system_utils.dart';
import '../main.dart';
import '../network/RestApis.dart';
import '../utils/app_config.dart';
import 'no_data_screen.dart';

class ChooseTransactionTypeScreen extends StatefulWidget {
  const ChooseTransactionTypeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseTransactionTypeScreen> createState() =>
      _ChooseTransactionTypeScreenState();
}

class _ChooseTransactionTypeScreenState
    extends State<ChooseTransactionTypeScreen> {
  // List<TransactionType> transactionTypes = [];
  int? selectedTransactionTypeId;
  bool isSale = false, isRent = false;

  iWantToSale() {
    setState(() {
      isRent = false;
      isSale = true;
    });
  }

  iWantToRent() {
    setState(() {
      isSale = false;
      isRent = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchTransactionTypes();
  }

  // Future<void> fetchTransactionTypes() async {
  //   appStore.setLoading(true);
  //   await getTransactionTypesApi().then((value) {
  //     transactionTypes = value;
  //     appStore.setLoading(false);
  //     setState(() {});
  //   }).catchError((error) {
  //     appStore.setLoading(false);
  //     log(error);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print('dataaaaaaaaa:${data!.slider!.length}');
    return Observer(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            leading: Image.asset(
              ic_logo,
              height: 40,
              width:
                  40, /* color: appStore.isDarkModeOn ? Colors.white : primaryColor, fit: BoxFit.fill */
            ).paddingOnly(left: 16, top: 8, bottom: 8),
            title: Text("اختار نوع المعاملة"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      iWantToSale();
                      selectedTransactionTypeId =
                          1; // Assuming 1 is the ID for Sale
                      DashboardScreen(
                        transactionType: selectedTransactionTypeId,
                        isSplash: false,
                      ).launch(context, isNewTask: false);
                    },
                    child: TransactionTypeCard(
                        isSelected: isSale, imagePath: ic_sale, type: 'بيع'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      iWantToRent();
                      selectedTransactionTypeId =
                          0; // Assuming 0 is the ID for Rent
                      DashboardScreen(
                        transactionType: selectedTransactionTypeId,
                        isSplash: false,
                      ).launch(context, isNewTask: true);
                    },
                    child: TransactionTypeCard(
                        isSelected: isRent, imagePath: ic_rent, type: 'ايجار'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: size.width * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "مساحة اعلانية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: 'Cairo',
                        color: appStore.isDarkModeOn
                            ? textOnDarkMode
                            : textOnLightMode,
                      ),
                    ).paddingOnly(top: 16, bottom: 16),
                  ),
                ],
              ),
            ),
          )
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: ElevatedButton(
          //     onPressed: selectedTransactionTypeId != null
          //         ? () {
          //             // Navigate to the next screen with the selected transaction type
          //             log("Selected Transaction Type ID: $selectedTransactionTypeId");
          //           }
          //         : null,
          //     child: Text("Continue"),
          //     style: ElevatedButton.styleFrom(
          //       // primary: Theme.of(context).primaryColor,
          //       // onPrimary: Theme.of(context).cardColor,
          //       padding: EdgeInsets.symmetric(vertical: 16),
          //       textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          );
    });
  }
}
