import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_pro/animations/fade_in_slide.dart';
import 'package:prayer_pro/screens/home_screen/home_screen.dart';
import 'package:prayer_pro/utils/color_res.dart';
import 'package:prayer_pro/utils/utils.dart';
import 'package:restart_app/restart_app.dart';
import 'package:geocoding/geocoding.dart';

import '../../prayer_model.dart';
import '../../services/api_service.dart';
import '../../utils/svg_res.dart';
import 'package:prayer_pro/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchPrayers();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: ColorRes.darkPurpleColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorRes.lightPurpleColor,
              ColorRes.darkPurpleColor,
            ],
          )),
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: -100,
                  child: SvgPicture.asset(
                    SvgRes.singleMosque_,
                  )),
              Positioned(
                  bottom: 280,
                  left: 130,
                  child: SvgPicture.asset(
                    SvgRes.svgStarWhite,
                    height: 30,
                    width: 30,
                  )),
              Positioned(
                  top: 130,
                  right: 50,
                  child: SvgPicture.asset(
                    SvgRes.svgStarPurple,
                    height: 15,
                    width: 15,
                  )),
              Positioned(
                  top: 90,
                  left: 30,
                  child: SvgPicture.asset(
                    SvgRes.svgCircleWhite,
                    height: 5,
                    width: 5,
                  )),
              Positioned(
                  bottom: 400,
                  right: 100,
                  child: SvgPicture.asset(
                    SvgRes.svgCircleWhite,
                    height: 10,
                    width: 10,
                  )),
              Positioned(
                  bottom: 150,
                  right: 30,
                  child: SvgPicture.asset(
                    SvgRes.svgCircleWhite,
                    height: 6,
                    width: 6,
                  )),
              Positioned(
                  top: screenHeight(context) * 0.25,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            SvgRes.svgMinar,
                            height: 120,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "PRAYER",
                                  style: GoogleFonts.delaGothicOne(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    height: 1.0,
                                  ),
                                ),
                                TextSpan(
                                  text: "\nPRO",
                                  style: GoogleFonts.delaGothicOne(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    height: 1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("O B S E R V E    N A M A Z",
                          style: GoogleFonts.belanosima(
                            color: Colors.white70,
                            fontSize: 18.0,
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _fetchPrayers() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    bool permissionCheck = (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always);
    debugPrint(":: Service = $serviceEnabled , Permission = $permissionCheck");

    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
    }
    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }

    if (permissionCheck) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        String locationName = "${placeMarks[0].subAdministrativeArea}, ${placeMarks[0].country}";

        dynamic response = await _apiService.fetchPrayers(
            date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
            latitude: position.latitude,
            longitude: position.longitude,
            school: 1,
            adjustment: -1);
        PrayerModel prayerResponse = PrayerModel.fromJson(response);

        List<String> prayerList = [];

        Map<String, dynamic> timingsMap = prayerResponse.data!.timings!.toPrayerJson();
        timingsMap.forEach((key, value) {
            prayerList.add('$key: $value');
            print('$key: ${value.toString().convertTo12HourFormat()}');

        });

        // Print the list
        print(prayerList);



        setState(() {
          navigateReplaceTo(
              context, HomeScreen(prayerResponse: prayerResponse,locationName:locationName,prayerList:prayerList));
        });
      } catch (e) {
        debugPrint('Error fetching prayers: $e');
        showInternetDialog();
      }
    }
  }

  showInternetDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Oops! looks like you don't have active internet connection.\n\nPlease connect with stable network.",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _fetchPrayers();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.only(
                          top: 20, right: 10, left: 10, bottom: 20),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: ColorRes.darkPurpleColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Try Again",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
