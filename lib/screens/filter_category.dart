import 'package:flutter/material.dart';
import 'package:orex/extensions/app_button.dart';
import 'package:orex/extensions/colors.dart';
import 'package:orex/extensions/extension_util/context_extensions.dart';
import 'package:orex/extensions/extension_util/widget_extensions.dart';
import 'package:orex/main.dart';
import 'package:orex/models/filter_category_model.dart';
import 'package:orex/screens/category_selected_screen.dart';
import 'package:orex/utils/colors.dart';

class FilterCategory extends StatefulWidget {
  final String? categoryName;
  final int? categoryId;
  const FilterCategory({super.key, this.categoryName, this.categoryId});

  List<FilterCategoryModel> get filterCategoryList => [
        FilterCategoryModel(name: 'Price', options: [
          Options(name: 'test1'),
          Options(name: 'test2'),
          Options(name: 'test3')
        ]),
        FilterCategoryModel(
            name: 'Location',
            options: [Options(name: 'test1'), Options(name: 'test2')]),
        FilterCategoryModel(name: 'Type', options: [
          Options(name: 'test1'),
          Options(name: 'test2'),
          Options(name: 'test3'),
          Options(name: 'test4')
        ]),
        FilterCategoryModel(name: 'Amenities', options: [
          Options(name: 'test1'),
          Options(name: 'test2'),
          Options(name: 'test5')
        ]),
      ];
  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName ?? 'Filter Category'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return filterItem(widget.filterCategoryList[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: widget.filterCategoryList.length,
            ),
            AppButton(
              padding: EdgeInsets.zero,
              text: language.Continue,
              width: context.width(),
              color: primaryColor,
              elevation: 0,
              onTap: () {
                CategorySelectedScreen(
                  categoryId: widget.categoryId ?? 0,
                  categoryName: widget.categoryName ?? '',
                ).launch(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget filterItem(FilterCategoryModel? model) {
    print('model!.toJson(): ${model?.toJson()}');
    return DropdownButtonFormField<Options>(
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: black),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: appStore.isDarkModeOn ? cardDarkColor : Color(0xffE9E9E9),
        hintText: model?.name ?? 'Filter',
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        // ),
      ),
      items: model?.options!
          .map((option) => DropdownMenuItem<Options>(
                value: option,
                child: Text(option.name ?? ''),
              ))
          .toList(),
      onChanged: (value) {
        // Handle filter selection
        print('Selected filter: ${value?.name}');
      },
    );
  }
}
