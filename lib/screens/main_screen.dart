import 'package:flutter/material.dart';
import 'package:orex/extensions/extension_util/widget_extensions.dart';

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
    String? selectedCity;
  String? selectCityName;
 Future<void> getData() async {
    appStore.setLoading(true);
    await getDashBoardData({"latitude": userStore.latitude, "longitude": userStore.longitude, "city": userStore.cityName, "player_id": getStringAsync(PLAYER_ID)}).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: Image.asset(ic_logo, height: 40, width: 40, /* color: appStore.isDarkModeOn ? Colors.white : primaryColor, fit: BoxFit.fill */).paddingOnly(left: 16, top: 8, bottom: 8),
        title: Text(language.selectCity),
        centerTitle: true,
      ),
      body: 
            Column(
              mainAxisSize: MainAxisSize.max,
              
              children: [

             if(data?.propertyCity?.isNotEmpty ?? false) GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 1.0,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.0),
                  itemCount: data!.propertyCity?.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: appStore.isDarkModeOn ? cardDarkColor : primaryExtraLight, 
                      borderRadius: radius(24),
                    ),
                    child: Column(
                      children: [
                        Expanded(child: cachedImage(
                          data!.propertyCity![index].images.toString(),
                          fit: BoxFit.cover,
                          
                        ).cornerRadiusWithClipRRect(24)
                        ),
                        Text(
                          data!.propertyCity![index].name.toString(),
                          style: primaryTextStyle(color: primaryColor, size: 16)
                        ).paddingBottom(8)
                      ],
                    ),
                  ).paddingOnly(left: 8, right: 8, top: 10, bottom: 10).center().onTap(() async {
                          selectedCity = data!.propertyCity![index].name.toString();
                          selectCityName = selectedCity;
                          userStore.setUserCity(selectCityName!);

                          

                       


                          DashboardScreen().launch(context, isNewTask: true);
                        }),
                ),
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
              ],
            ).visible(userStore.cityName.isEmpty).center(),
    );
  }
}