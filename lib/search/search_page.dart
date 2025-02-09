// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weatherapp/search/grid_list_widget.dart';
import 'package:minimal_weatherapp/search/text_form_field_widget.dart';
import 'package:minimal_weatherapp/style/color_scheme.dart';

import "/style/context_extension.dart";
import '../services/control.dart';
import '../style/text_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final cityTextController = TextEditingController();
  final apiList = ApiListFillVoidClass();
  final textThemeLight = TextThemeLight.instance!;
  final colorScheme = ColorSchemeLight.instance!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width2 * 3,
            right: context.width2 * 3,
            top: context.height2 * 3,
          ),
          child: Column(
            children: [
              Text("Search Location", style: textThemeLight.headline1),
              SizedBox(
                height: context.lowContainer,
              ),
              searchBarWidget(context, textThemeLight, colorScheme),
              SizedBox(
                height: context.lowContainer,
              ),
              listFillWidget(textThemeLight, apiList),
            ],
          ),
        ),
      ),
    );
  }

  Row searchBarWidget(BuildContext context, TextThemeLight textThemeLight,
      ColorSchemeLight colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.width2 * 70,
          height: context.mediumContainer,
          child: textFormField(
              cityTextController, textThemeLight, colorScheme, context),
        ),
        SizedBox(
          width: context.lowContainer,
          child: TextButton(
              onPressed: () async {
                var result =
                    await apiList.apiListFillVoid(cityTextController.text);
                cityTextController.clear();
                if (result == true) {
                  setState(() {
                    apiList.imageChangeVoid();
                    print(apiList.hourlyImageList);
                  });
                } else {
                  // error... what do u wanna do ?
                }
              },
              child: Icon(
                Icons.search,
                color: colorScheme.purple,
              )),
        ),
        SizedBox(
          width: context.lowContainer,
          child: TextButton(
              onPressed: () {
                apiList.showSelectedCountryMap.clear();
                setState(() {});
              },
              child: Icon(
                Icons.delete,
                color: colorScheme.purple,
              )),
        ),
      ],
    );
  }
}
