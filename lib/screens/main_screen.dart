import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orex/extensions/extension_util/widget_extensions.dart';
import 'package:orex/screens/choose_transaction_type_screen.dart';
import 'package:orex/screens/filter_category.dart';
import 'package:orex/models/category_list_model.dart';
import 'package:orex/network/RestApis.dart';

import '../extensions/colors.dart';
import '../extensions/decorations.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../network/RestApis.dart';
import '../utils/app_common.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import 'dashboard_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // add by Axon
  bool showSacandDropdown = false;
  bool showCategoryDropdown = false;

  String? selectedCity;
  String? selectCityName;
  String? selectedCategoryId;
  String? selectedCategoryName;
  List<CategoryData> categoryData = [];

  Future<void> getData() async {
    appStore.setLoading(true);
    await getDashBoardData({
      "latitude": userStore.latitude,
      "longitude": userStore.longitude,
      "city": userStore.cityName,
      "player_id": getStringAsync(PLAYER_ID)
    }).then((value) {
      data = value;
      userStore.setMinPrice(data!.filterConfiguration!.minPrice.toString());
      userStore.setMaxPrice(data!.filterConfiguration!.maxPrice.toString());

      setState(() {});
    }).catchError((e) {
      setState(() {});
      print("=======>${e.toString()}");
    }).whenComplete(
      () => appStore.setLoading(false),
    );
  }

  Future<void> getPropertyCategory() async {
    // get ready for category data
    appStore.setLoading(true);
    getCategory(page: 1).then((value) {
      categoryData = value.data!;
      appStore.setLoading(false);
      setState(() {
        print("categoryData: ${categoryData.length}");
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
        print('---------------------------------------');
      });
    }).catchError((e) {
      appStore.setLoading(false);
      print("Category Error: ${e.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          ic_logo,
          height: 40,
          width:
              40, /* color: appStore.isDarkModeOn ? Colors.white : primaryColor, fit: BoxFit.fill */
        ).paddingOnly(left: 16, top: 8, bottom: 8),
        title: Text(language.selectCity),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //?? add by Axon
            // old code
            _buldGrid(),
            // new code
            _buildFirstDropdown(),
            _buildSecondDropdown(),
            _buildCategoryDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buldGrid() {
    if (data?.propertyCity?.isNotEmpty ?? false) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            // crossAxisSpacing: 10.0,
            // mainAxisSpacing: 10.0,
            childAspectRatio: 1.5 / 1.9),
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        itemCount: data!.propertyCity?.length ?? 0,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(8.0),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor:
                appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight,
            borderRadius: radius(24),
          ),
          child: Column(
            children: [
              Expanded(
                  child: cachedImage(
                data!.propertyCity![index].images.toString(),
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(24)),
              Text(data!.propertyCity![index].name.toString(),
                      style: primaryTextStyle(color: primaryColor, size: 16))
                  .paddingBottom(8)
            ],
          ),
        )
            .paddingOnly(left: 8, right: 8, top: 10, bottom: 10)
            .center()
            .onTap(() async {
          selectedCity = data!.propertyCity![index].id.toString();
          selectCityName = data!.propertyCity![index].name.toString();
          userStore.setUserCity(selectCityName!).then((value) {
            setState(() {
              selectedCity = data!.propertyCity![index].id.toString();
              selectCityName = data!.propertyCity![index].name.toString();
              showSacandDropdown = true;
            });
          });
          // ChooseTransactionTypeScreen()
          //     .launch(context, isNewTask: false);
          // userStore.setUserCity(selectCityName!).then((value) =>
          //     ChooseTransactionTypeScreen()
          //         .launch(context, isNewTask: false));

          // DashboardScreen().launch(context, isNewTask: true);
        }),
      );
      // Container(
      //   constraints: BoxConstraints(minWidth: 200,minHeight: 200),
      //   decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight, borderRadius: radius(24),),
      //   child:
      // ),
      // WaveAnimation(
      //   key: _waveAnimationKey,
      //   size: 80.0,
      //   color: primaryColor.withOpacity(0.3), // You can specify your desired color here
      //   centerChild: Image.asset(ic_logo, color: primaryExtraLight, height: 22, width: 24),
      // ),
      // Text(language.fetchingYourCurrentLocation, style: secondaryTextStyle(color: primaryColor))
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildFirstDropdown() {
    if (data?.propertyCity?.isNotEmpty ?? false) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: selectedCity,
          decoration: InputDecoration(
            labelText: language.selectCity,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: data!.propertyCity!
              .map((city) => DropdownMenuItem<String>(
                    value: city.id.toString(),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: cachedImage(
                            (city.images != null && city.images!.isNotEmpty)
                                ? city.images!
                                : 'https://via.placeholder.com/32',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(city.name ?? ''),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedCity = value;
              // Find the city name by id
              selectCityName = data!.propertyCity!
                  .firstWhere((city) => city.id.toString() == value)
                  .name;
            });
            userStore.setUserCity(selectCityName!).then((_) {
              setState(() {
                showSacandDropdown = true;
                // showCategoryDropdown = true;
              });
              // ChooseTransactionTypeScreen().launch(context, isNewTask: false);
            });
          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildSecondDropdown() {
    return showSacandDropdown
        ? ChooseTransactionTypeDropdown(onChanged: (value) {
            setState(() {
              showCategoryDropdown = true;
            });
            getPropertyCategory();
          })
        : SizedBox.shrink();
  }

  Widget _buildCategoryDropdown() {
    print("showCategoryDropdown: $showCategoryDropdown");
    print("categoryData length: ${categoryData.length}");

    if (!showCategoryDropdown) {
      return SizedBox.shrink();
    }

    if (categoryData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: selectedCategoryId,
        decoration: InputDecoration(
          labelText: language.category,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: categoryData
            .map((category) => DropdownMenuItem<String>(
                  value: category.id.toString(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: cachedImage(
                          category.categoryImage ??
                              'https://via.placeholder.com/32',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                          color: appStore.isDarkModeOn
                              ? textOnDarkMode
                              : textOnLightMode,
                        ),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          category.name.toString(),
                          style: primaryTextStyle(
                            size: 16,
                            color: appStore.isDarkModeOn
                                ? textOnDarkMode
                                : textOnLightMode,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedCategoryId = value;
            selectedCategoryName = categoryData
                .firstWhere((category) => category.id.toString() == value)
                .name;
          });

          // Navigate to FilterCategory
          FilterCategory(
            categoryId: int.parse(selectedCategoryId!),
            categoryName: selectedCategoryName!,
            transactionType:
                null, // You can pass the transaction type here if needed
          ).launch(context);
        },
      ),
    );
  }
}
