import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer_pro/screens/home_screen/home_screen.dart';
import 'package:prayer_pro/utils/color_res.dart';
import 'package:prayer_pro/utils/utils.dart';

import '../../utils/svg_res.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
   Timer(const Duration(seconds: 5), () {
     navigateReplaceTo(context,const HomeScreen());
   });
    super.initState();
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
                    SvgRes.singleMosque,
                    color: Colors.white12,
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
}
