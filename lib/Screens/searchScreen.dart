import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/theme/colors.dart';
import 'package:weather_app/theme/textStyle.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  FloatingSearchBarController fsc = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: fsc,
        hint: 'Enter city name',
        clearQueryOnClose: false,
        scrollPadding: const EdgeInsets.only(top: 16.0, bottom: 56.0),
        transitionDuration: const Duration(milliseconds: 400),
        borderRadius: BorderRadius.circular(16.0),
        transitionCurve: Curves.easeInOut,
        accentColor: primaryBlue,
        hintStyle: regularText,
        queryStyle: regularText,
        physics: const BouncingScrollPhysics(),
        elevation: 2.0,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {},
        onSubmitted: (query) async {
          Navigator.pop(context);
          fsc.close();
          await Provider.of<WeatherProvider>(context, listen: false)
              .getWeather(query);
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: PhosphorIcon(
              PhosphorIconsBold.magnifyingGlass,
              color: primaryBlue,
            ),
          ),
          FloatingSearchBarAction.icon(
            showIfClosed: false,
            showIfOpened: true,
            icon: PhosphorIcon(
              PhosphorIconsBold.x,
              color: primaryBlue,
            ),
            onTap: () {
              if (fsc.query.isEmpty) {
                fsc.close();
              } else {
                fsc.clear();
              }
            },
          ),
        ],
        builder: (context, transition) {
          return Container();
        },
      ),
    );
  }
}
