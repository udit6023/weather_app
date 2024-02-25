// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';



import 'package:geolocator/geolocator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/locationError.dart';
import 'package:weather_app/Screens/searchScreen.dart';

import '../provider/weatherProvider.dart';
import '../theme/colors.dart';
import '../theme/textStyle.dart';
import '../widgets/WeatherInfoHeader.dart';
import '../widgets/mainWeatherDetail.dart';
import '../widgets/mainWeatherInfo.dart';

import 'requestError.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  void initState() {
    requestWeather();
    super.initState();
  }

  Future<void> requestWeather() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
         await Provider.of<WeatherProvider>(context, listen: false)
        .signOut();
      },
      child: Icon(Icons.exit_to_app),
      ),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        title: Text('Weather App'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) => CustomSearchBar())
            );
          }, icon: PhosphorIcon(
              PhosphorIconsBold.magnifyingGlass,
              color: primaryBlue,
            ),
          )
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProv, _) {
          if (!weatherProv.isLoading && !weatherProv.isLocationserviceEnabled)
            return LocationServiceErrorDisplay();

          if (!weatherProv.isLoading &&
              weatherProv.locationPermission != LocationPermission.always &&
              weatherProv.locationPermission != LocationPermission.whileInUse) {
            return LocationPermissionErrorDisplay();
          }

          if (weatherProv.isRequestError) return RequestErrorDisplay();

          return Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12.0).copyWith(
                  top: 
                      MediaQuery.viewPaddingOf(context).top
                ),
                children: [
                  WeatherInfoHeader(),
                  const SizedBox(height: 50.0),
                  MainWeatherInfo(),
                  const SizedBox(height: 50.0),
                  MainWeatherDetail(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}


