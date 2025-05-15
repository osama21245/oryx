// import 'package:flutter/material.dart';
// import '../extensions/extension_util/context_extensions.dart';
// import '../extensions/extension_util/int_extensions.dart';
// import '../extensions/extension_util/widget_extensions.dart';
// import '../extensions/decorations.dart';
// import '../extensions/text_styles.dart';
// import '../main.dart';
// import '../utils/colors.dart';
// import '../utils/images.dart';
//
// class SmartSuggestionAllComponent extends StatefulWidget {
//   const SmartSuggestionAllComponent({super.key});
//
//   @override
//   State<SmartSuggestionAllComponent> createState() => _SmartSuggestionAllComponentState();
// }
//
// class _SmartSuggestionAllComponentState extends State<SmartSuggestionAllComponent> {
//   bool select = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       child: Column(children: [
//         Stack(
//           children: [
//             Stack(
//               children: [
//                 Image.asset(
//                   "assets/ic_women.jpg",
//                   width: context.width(),
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   fit: BoxFit.fill,
//                 ).cornerRadiusWithClipRRect(12.0),
//               ],
//             ),
//             Positioned(
//               bottom: 10,
//               left: 10.0,
//               right: 10.0,
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(8.0),
//                    backgroundColor: appStore.isDarkModeOn ? iconColor :primaryExtraLight),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text("₹ 15,000 / ${language.month}", style: primaryTextStyle(color: primaryColor)).expand(),
//                         Text("2 BHK Flat", style: primaryTextStyle(color: primaryColor)),
//                       ],
//                     ),
//                     5.height,
//                     Text("Sheth Rushabh Avenue, Gulab...", maxLines: 2, style: secondaryTextStyle(color: Colors.grey)),
//                     2.height,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text("Fully Furnished", style: secondaryTextStyle(color: appStore.isDarkModeOn ? selectIconColor :scaffoldColorDark)).expand(),
//                         Text("1000 sq ft", style: secondaryTextStyle(color: appStore.isDarkModeOn ? selectIconColor :scaffoldColorDark)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 right: 10.0,
//                 top: 10.0,
//                 child: Container(
//                   padding: EdgeInsets.all(6),
//                   decoration: boxDecorationWithRoundedCorners(
//                     borderRadius: BorderRadius.circular(50),
//                     backgroundColor: primaryExtraLight,
//                   ),
//                   child: Image.asset(select ? ic_favorite_fill :ic_fav, height: 22, width: 22),
//                 ).onTap(() {setState(() {
//                   select = !select;
//                 });}))
//           ],
//         ),
//         10.height,
//         // ContactComponents(customer: Customer())
//       ]).paddingSymmetric(horizontal: 16),
//     );
//   }
// }
