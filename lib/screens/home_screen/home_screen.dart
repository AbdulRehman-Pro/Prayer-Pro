import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prayer_pro/animations/fade_in_slide.dart';
import 'package:prayer_pro/prayer_model.dart';
import 'package:prayer_pro/utils/utils.dart';

import '../../utils/color_res.dart';
import '../../utils/svg_res.dart';

class HomeScreen extends StatefulWidget {
  final PrayerModel prayerResponse;
  final String locationName;
  final List<String> prayerList;

  const HomeScreen(
      {super.key,
      required this.prayerResponse,
      required this.locationName,
      required this.prayerList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Data _prayerResponse;
  late Timer _timer;
  late String _currentTime;
  late String _currentTimeAmPm;

  @override
  void initState() {
    super.initState();
    _prayerResponse = widget.prayerResponse.data!;

    // Initialize the current time
    _updateCurrentTime();
    // Start a timer to update the current time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentTime();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  void _updateCurrentTime() {
    setState(() {
      // Get the current time
      _currentTime = DateFormat('hh:mm').format(DateTime.now());
      _currentTimeAmPm = DateFormat('a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 70),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorRes.lightestPurpleColor,
                Colors.white,
              ],
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInSlide(
                      duration: .5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  SvgRes.svgLocation,
                                  color: Colors.black45,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.locationName,
                                  style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInSlide(
                      duration: .6,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _currentTime,
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 50),
                                      ),
                                      TextSpan(
                                          text: _currentTimeAmPm,
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            height: 0,
                                          ))
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${_prayerResponse.timings!.getNextPrayer(DateTime.now()).keys.first} less than ",
                                        style: GoogleFonts.inter(
                                            color: Colors.black45,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: _prayerResponse.timings!
                                                .getNextPrayer(DateTime.now())[
                                            'TimeDifference'],
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              SvgRes.svgFullMosque,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInSlide(
                      duration: .7,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [
                            Text(
                              "Date",
                              style: GoogleFonts.inter(
                                  color: Colors.black45,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 1,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(100)),
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeInSlide(
                      duration: .8,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          _prayerResponse.date!.hijri!.formattedDate,
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              height: 2,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    FadeInSlide(
                      duration: .9,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          _prayerResponse.date!.gregorian!.formattedDate,
                          style: GoogleFonts.inter(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     FadeInSlide(
                //       duration: 1.0,
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.only(top: 20),
                //         width: screenWidth(context) * .95,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOff),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 Text(
                //                   "Fajr",
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 )
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Text(
                //                   convertTo12HourFormat(
                //                       _prayerResponse.timings!.fajr!),
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOn),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     FadeInSlide(
                //       duration: 1.1,
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.only(top: 20),
                //         width: screenWidth(context) * .95,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOff),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 Text(
                //                   "Dhuhr",
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 )
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Text(
                //                   convertTo12HourFormat(
                //                       _prayerResponse.timings!.dhuhr!),
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOn),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     FadeInSlide(
                //       duration: 1.2,
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.only(top: 20),
                //         width: screenWidth(context) * .95,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOff),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 Text(
                //                   "Asr",
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 )
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Text(
                //                   convertTo12HourFormat(
                //                       _prayerResponse.timings!.asr!),
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOn),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     FadeInSlide(
                //       duration: 1.3,
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.only(top: 20),
                //         width: screenWidth(context) * .95,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOff),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 Text(
                //                   "Maghrib",
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 )
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Text(
                //                   convertTo12HourFormat(
                //                       _prayerResponse.timings!.maghrib!),
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOn),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     FadeInSlide(
                //       duration: 1.4,
                //       child: Container(
                //         height: 50,
                //         margin: const EdgeInsets.only(top: 20),
                //         width: screenWidth(context) * .95,
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(15),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOff),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 Text(
                //                   "Isha",
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 )
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Text(
                //                   convertTo12HourFormat(
                //                       _prayerResponse.timings!.isha!),
                //                   style: GoogleFonts.inter(
                //                       color: Colors.black54,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 14),
                //                 ),
                //                 const SizedBox(
                //                   width: 20,
                //                 ),
                //                 SvgPicture.asset(SvgRes.svgSoundOn),
                //                 const SizedBox(
                //                   width: 10,
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: widget.prayerList.length,
                        itemBuilder: (context, index) {
                          List<String> keyValue =
                              widget.prayerList[index].split(':');
                          String prayerName = keyValue[0].trim();
                          String prayerTime =
                              "${keyValue[1].trim()}:${keyValue[2].trim()}";

                          String nextPrayerName = '';
                          String nextPrayerTime = '';
                          //
                          // if (index < widget.prayerList.length - 1) {
                          //   List<String> nextKeyValue =
                          //       widget.prayerList[0].split(':');
                          //   nextPrayerName = nextKeyValue[0].trim();
                          //   nextPrayerTime =
                          //       "${nextKeyValue[1].trim()}:${nextKeyValue[2].trim()}";
                          // }

                          if (index < widget.prayerList.length - 1) {
                            List<String> nextKeyValue = widget.prayerList[index + 1].split(':');
                            nextPrayerName = nextKeyValue[0].trim();
                            nextPrayerTime = "${nextKeyValue[1].trim()}:${nextKeyValue[2].trim()}";
                          }

                          bool isCurrentPrayerTime =
                              checkIfCurrentPrayerTime(prayerTime, nextPrayerTime,index);
                          return FadeInSlide(
                            duration: 1.0 + (index * 0.1).toDouble(),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(
                                  top: index == 0 ? 20 : 10,
                                  left: 10,
                                  right: 10),
                              decoration: BoxDecoration(
                                  color: isCurrentPrayerTime
                                      ? ColorRes.lightestPurpleColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: isCurrentPrayerTime
                                            ? ColorRes.lightPurpleColor
                                            : Colors.transparent,
                                        blurRadius: 3,
                                        spreadRadius: 1.5,
                                        offset: const Offset(0, 1.5))
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(SvgRes.svgSoundOff),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        prayerName,
                                        style: GoogleFonts.inter(
                                            color: isCurrentPrayerTime
                                                ? Colors.black
                                                : Colors.black54,
                                            fontWeight: isCurrentPrayerTime
                                                ? FontWeight.w800
                                                : FontWeight.bold,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        prayerTime.convertTo12HourFormat(),
                                        style: GoogleFonts.inter(
                                            color: isCurrentPrayerTime
                                                ? Colors.black
                                                : Colors.black54,
                                            fontWeight: isCurrentPrayerTime
                                                ? FontWeight.w800
                                                : FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SvgPicture.asset(SvgRes.svgSoundOn),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                )
              ],
            )),
      ),
    );
  }

  bool checkIfCurrentPrayerTime(String prayerTime, String nextPrayerTime, int index) {
    DateTime now = DateTime.now();

    List<String> parts = prayerTime.split(':');
    int prayerHour = int.parse(parts[0]);
    int prayerMinute = int.parse(parts[1]);

    int nextPrayerHour;
    int nextPrayerMinute;

    if (index < widget.prayerList.length - 1) {
      List<String> nextParts = nextPrayerTime.split(':');
      nextPrayerHour = int.parse(nextParts[0]);
      nextPrayerMinute = int.parse(nextParts[1]);
    } else {
      // Treat the next prayer time as the same as the first prayer time
      List<String> firstPrayerParts = widget.prayerList[0].split(':');
      nextPrayerHour = int.parse(firstPrayerParts[1]);
      nextPrayerMinute = int.parse(firstPrayerParts[2]);
      // Ensure that next prayer is greater than current prayer time
      if (nextPrayerHour < prayerHour || (nextPrayerHour == prayerHour && nextPrayerMinute < prayerMinute)) {
        nextPrayerHour += 24; // Add 24 hours to make it greater than current time
      }
    }

    if ((now.hour > prayerHour || (now.hour == prayerHour && now.minute >= prayerMinute)) &&
        (now.hour < nextPrayerHour || (now.hour == nextPrayerHour && now.minute < nextPrayerMinute))) {
      return true;
    }

    return false;
  }


//
  // bool checkIfCurrentPrayerTime(String prayerTime, String nextPrayerTime, int index) {
  //   DateTime now = DateTime.now();
  //
  //   List<String> parts = prayerTime.split(':');
  //   int prayerHour = int.parse(parts[0]);
  //   int prayerMinute = int.parse(parts[1]);
  //
  //   int? nextPrayerHour;
  //   int? nextPrayerMinute;
  //
  //   if (index < widget.prayerList.length - 1) {
  //     List<String> nextParts = nextPrayerTime.split(':');
  //     nextPrayerHour = int.parse(nextParts[0]);
  //     nextPrayerMinute = int.parse(nextParts[1]);
  //   } else if (widget.prayerList.isNotEmpty) {
  //
  //     // Handle the case of the last prayer time of the day
  //     // If the current time is after the last prayer time but before midnight,
  //     // then the next prayer time is the first prayer time of the next day
  //     if (now.hour >= 19 && now.minute >= 43) {
  //       List<String> firstPrayerParts = widget.prayerList[0].split(':');
  //       nextPrayerHour = int.parse(firstPrayerParts[1]);
  //       nextPrayerMinute = int.parse(firstPrayerParts[2]);
  //     }
  //   }
  //
  //   if (nextPrayerHour != null && nextPrayerMinute != null) {
  //     if ((now.hour > prayerHour || (now.hour == prayerHour && now.minute >= prayerMinute)) &&
  //         (now.hour < nextPrayerHour || (now.hour == nextPrayerHour && now.minute < nextPrayerMinute))) {
  //       return true;
  //     }
  //   }
  //
  //   return false;
  // }



// bool checkIfCurrentPrayerTime(String prayerTime, String nextPrayerTime) {
  //   DateTime now = DateTime.now();
  //
  //   List<String> parts = prayerTime.split(':');
  //   int prayerHour = int.parse(parts[0]);
  //   int prayerMinute = int.parse(parts[1]);
  //
  //   // Ensure nextPrayerTime is not empty or null before attempting to split
  //   if (nextPrayerTime.isNotEmpty) {
  //     List<String> nextParts = nextPrayerTime.split(':');
  //     // Ensure nextParts has at least two elements before accessing
  //     if (nextParts.length >= 2) {
  //       int? nextPrayerHour = int.tryParse(nextParts[0]);
  //       int? nextPrayerMinute = int.tryParse(nextParts[1]);
  //
  //       if (nextPrayerHour != null && nextPrayerMinute != null) {
  //         if ((now.hour > prayerHour || (now.hour == prayerHour && now.minute >= prayerMinute)) &&
  //             (now.hour < nextPrayerHour || (now.hour == nextPrayerHour && now.minute < nextPrayerMinute))) {
  //           return true;
  //         }
  //       }
  //     }
  //   }
  //
  //   return false;
  // }

  //
  // bool checkIfCurrentPrayerTime(String prayerTime, int index) {
  //   DateTime now = DateTime.now();
  //   List<String> parts = prayerTime.split(':');
  //   int prayerHour = int.parse(parts[0]);
  //   int prayerMinute = int.parse(parts[1]);
  //   //
  //
  //   // List<String> nextParts = nextPrayerTime.split(':');
  //   // int nextPrayerHour = int.parse(nextParts[0]);
  //   // int nextPrayerMinute = int.parse(nextParts[1]);
  //
  //   if (((now.hour >= prayerHour) && (now.minute >= prayerMinute))) {
  //     List<String> nextKeyValue = widget.prayerList[index + 1].split(':');
  //     var nextPrayerName = nextKeyValue[0].trim();
  //     var nextPrayerTime =
  //         "${nextKeyValue[1].trim()}:${nextKeyValue[2].trim()}";
  //     List<String> parts = nextPrayerTime.split(':');
  //     int nextPrayerHour = int.parse(parts[0]);
  //     int nextPrayerMinute = int.parse(parts[1]);
  //     print(
  //         "Current Prayer ${prayerTime.convertTo12HourFormat()} - $index ::: $nextPrayerName : ${nextPrayerTime.convertTo12HourFormat()}");

  //     if (((now.hour >= prayerHour) && (prayerHour <= nextPrayerHour)) &&
  //         ((now.minute >= prayerMinute) &&
  //             (prayerMinute <= nextPrayerMinute))) {
  //       return true;
  //     }
  //   }
  //
  //   return false;
  // }
}
