import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../components/app_bar_components.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/colors.dart';
import '../extensions/decorations.dart';
import '../extensions/extension_util/context_extensions.dart';
import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../extensions/horizontal_list.dart';
import '../extensions/loader_widget.dart';
import '../extensions/price_widget.dart';
import '../extensions/shared_pref.dart';
import '../extensions/system_utils.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../models/dashBoard_response.dart';
import '../models/my_properties_model.dart';
import '../models/property_type_model.dart';
import '../network/RestApis.dart';
import '../screens/dashboard_screen.dart';
import '../screens/search_screen.dart';
import '../utils/app_common.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import 'home_screen.dart';

class FilterScreen extends StatefulWidget {
 final bool isSelect;

  FilterScreen({this.isSelect = false});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {
  TextEditingController mapLocation = TextEditingController();

  int selectPosted = 0;
  int propertyForId = 0;
  int page = 1;
  int? numPage;
  int? currentIndex = 0;

  bool isLastPage = false;
  bool select = false;
  bool isFilterList = false;

  num? latitude;
  num? longitude;

  String? cityName;

  List<PropertyTypeModel> list = [];
  List<Property> filterProperty = [];
  List<PropertyTypeList> propertyForList = [];
  List<PropertyTypeList> propertyList = [];

  String? propertySince;

  getList() {
    propertyForList.add(PropertyTypeList(0, language.anytime, false));
    propertyForList.add(PropertyTypeList(1, language.lastWeek, false));
    propertyForList.add(PropertyTypeList(2, language.yesterday, false));
  }

  getPropertyList() {
    propertyList.add(PropertyTypeList(0.toInt(), language.forRent, false));
    propertyList.add(PropertyTypeList(1.toInt(), language.forSell, false));
  }

  late RangeValues _values;
  RangeValues? _apiSendValues;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    getList();
    getPropertyList();
    _values = RangeValues(userStore.minPrice.toDouble(), userStore.maxPrice.toDouble());
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  latLongFunction(num? filterLatitude, num? filterLongitude) {
    latitude = filterLatitude;
    longitude = filterLongitude;
  }

  address(String? finalMapAddress) {
    mapLocation.text = finalMapAddress.toString();
    setState(() {});
  }

  Future<void> filterData() async {
    if (_apiSendValues == null) {
      _apiSendValues = RangeValues(0, 0);
    }

    appStore.setLoading(true);
    Map req;
    req = {
      "posted_since": propertySince,
      "latitude": latitude,
      "longitude": longitude,
      "start_price": _apiSendValues!.start,
      "end_price": _apiSendValues!.end,
      "property_for": propertyForId.toString(),
      "property_type": cityName,
    };

    await filterApi(req).then((value) {
      filterProperty.clear();
      Iterable it = value.property!;
      it.map((e) => filterProperty.add(e)).toList();
      appStore.setLoading(false);

      print("Request Is For Filter ==> " + req.toString());

      SearchScreen(
        propertyId: propertyForId,
        propertySince: propertySince,
        budgetMaxPrice: _apiSendValues!.end,
        budgetMinPrice: _apiSendValues!.start,
        latitude: latitude,
        longitude: longitude,
        isFilter: true,
        mPropertyData: filterProperty,
        isBack: false,
      ).launch(context);

      setState(() {});
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language.filter,
          titleSpace: 0,
          context1: context,
          actions: [
            Text(language.clearFilter, style: secondaryTextStyle(color: appStore.isDarkModeOn ? Colors.white : primaryColor)).paddingSymmetric(horizontal: 16, vertical: 16).onTap(() {
              propertyForList.clear();
              propertyList.clear();
              list.clear();
              mapLocation.clear();
              init();
              setState(() {});
            })
          ],
          showBack: true,
          backWidget: Icon(appStore.selectedLanguage == 'ar' ? MaterialIcons.arrow_forward_ios : Octicons.chevron_left, color: primaryColor, size: 28).onTap(() {
            if (widget.isSelect == false) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashboardScreen()), (route) => true);
            } else {
              finish(context);
            }
          })),
      bottomNavigationBar: AppButton(
        width: context.width(),
        color: primaryColor,
        textColor: Colors.white,
        text: language.applyFilter,
        onTap: () {
          filterData();
          setState(() {});
        },
      ).paddingSymmetric(horizontal: 16, vertical: 24),
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalList(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: propertyList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: (context.width() - 50) / 2,
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radius(8),
                        backgroundColor: propertyList[index].select!
                            ? primaryColor
                            : appStore.isDarkModeOn
                                ? cardDarkColor
                                : primaryExtraLight),
                    child: Text(
                      propertyList[index].title.validate(),
                      style: primaryTextStyle(color: propertyList[index].select! ? Colors.white : grayColor),
                    ).center(),
                  ).onTap(() {
                    setState(() {
                      for (int i = 0; i < propertyList.length; i++) {
                        propertyList[i].select = i == index;
                        propertyForId = propertyList[index].id!;
                      }
                    });
                  });
                }),
            20.height,
            Text(language.priceRange, style: boldTextStyle()),
            20.height,
            SliderTheme(
              data: SliderThemeData(showValueIndicator: ShowValueIndicator.always),
              child: RangeSlider(
                values: RangeValues(_values.start, _values.end),
                min: getStringAsync(MIN_PRICE).toDouble(),
                max: getStringAsync(MAX_PRICE).toDouble(),
                onChanged: (RangeValues newValues) {
                  setState(() {
                    _values = RangeValues(newValues.start, newValues.end);
                    _apiSendValues = _values;
                  });
                },
                labels: RangeLabels(formatFilterNumberString(_values.start.toStringAsFixed(2).toDouble()), formatFilterNumberString(_values.end.toStringAsFixed(2).toDouble())),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceWidget(price: formatFilterNumberString(_values.start.toStringAsFixed(2).toDouble()), textStyle: primaryTextStyle(size: 14)),
                PriceWidget(price: formatFilterNumberString(_values.end.toStringAsFixed(2).toDouble()), textStyle: primaryTextStyle(size: 14))
              ],
            ),
            20.height,
            Text(language.postedSince, style: boldTextStyle()),
            10.height,
            HorizontalList(
                padding: EdgeInsets.zero,
                itemCount: propertyForList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: (context.width() - 63) / 3,
                    // width: context.width() * 0.28,
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radius(8),
                        backgroundColor: propertyForList[index].select!
                            ? primaryColor
                            : appStore.isDarkModeOn
                                ? cardDarkColor
                                : primaryExtraLight),
                    child: Text(
                      propertyForList[index].title.validate(),
                      style: primaryTextStyle(color: propertyForList[index].select! ? Colors.white : grayColor),
                    ).center(),
                  ).onTap(() {
                    setState(() {
                      for (int i = 0; i < propertyForList.length; i++) {
                        propertyForList[i].select = i == index;
                        propertySince = propertyForList[index].title;
                      }
                    });
                  });
                }),
            20.height,
            Text(language.location, style: boldTextStyle()),
            10.height,
            if (mapLocation.text.isNotEmpty)
              AppTextField(
                maxLines: 3,
                readOnly: true,
                controller: mapLocation,
                textFieldType: TextFieldType.OTHER,
                keyboardType: TextInputType.streetAddress,
                decoration: defaultInputDecoration(
                  context,
                ),
              ).visible(mapLocation.text.isNotEmpty),
            20.height.visible(mapLocation.text.isNotEmpty),
             citySelectionWidget(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            //   decoration: boxDecorationWithRoundedCorners(
            //       borderRadius: radius(8.0),
            //       backgroundColor: select
            //           ? primaryColor
            //           : appStore.isDarkModeOn
            //               ? cardDarkColor
            //               : primaryExtraLight),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.my_location_sharp, color: grayColor),
            //       10.width,
            //       Text(language.chooseLocation, style: primaryTextStyle(color: select ? Colors.white : grayColor)).center(),
            //     ],
            //   ),
            // ).onTap(() async {
            //   // PlaceAddressModel? res = await GoogleMapScreen(
            //   //   isFromFilter: true,
            //   //   onAddress: address,
            //   //   onLatLong: latLongFunction,
            //   // ).launch(context);
            //   // if (res != null) {}
            // })
          ],
        ).paddingSymmetric(horizontal: 16),
        Loader().center().visible(appStore.isLoading),
      ]),
    );
  }

   Widget citySelectionWidget() {
    return data != null
        ? SizedBox(
            width: double.infinity,
            height: 60,
            child: DropdownButtonFormField<String>(
              focusColor: Colors.transparent,
              alignment: Alignment.centerLeft,
              isExpanded: true,
              padding: EdgeInsets.zero,
              elevation: 0,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: primaryColor),
              borderRadius: radius(),
              decoration: InputDecoration(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  prefixIconConstraints: BoxConstraints(minWidth: 1),
                  prefixIcon: Image.asset(ic_map_point, color: primaryColor, width: 18, height: 18).paddingOnly(left: 14, top: 10, bottom: 10, right: 10),
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(borderRadius: radius(24), borderSide: BorderSide(color: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight, width: 1)),
                  border: OutlineInputBorder(borderRadius: radius(24), borderSide: BorderSide(color: appStore.isDarkModeOn ? cardDarkColor : primaryColor, width: 1)),
                  filled: true,
                  focusedBorder: OutlineInputBorder(borderRadius: radius(24), borderSide: BorderSide(color: Colors.transparent, width: 0)),
                  fillColor: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  enabled: true),
              isDense: true,
              hint: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  data!.propertyCity!.isNotEmpty
                      ? userStore.cityName.isEmpty
                          ? Text(data!.propertyCity![0].name.toString(), style: primaryTextStyle(color: primaryColor))
                          : Text(userStore.cityName, style: primaryTextStyle(color: primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis).expand()
                      : Text(language.selectCity, style: primaryTextStyle(color: primaryColor)),
                ],
              ),
              dropdownColor: context.cardColor,
              items: data!.propertyCity!.map((PropertyCity e) {
                return DropdownMenuItem<String>(
                  value: data!.propertyCity!.contains(userStore.cityName) ? userStore.cityName : e.name.validate(),
                  child: Text(e.name.validate(), style: primaryTextStyle(color: primaryColor), overflow: TextOverflow.ellipsis, softWrap: true, textAlign: TextAlign.end),
                );
              }).toList(),
              onChanged: (String? value) async {
                cityName = value??'';
                
              

                setState(() {});
              },
            ),
          ).paddingSymmetric(vertical: 8)
        : SizedBox();
  }

}
