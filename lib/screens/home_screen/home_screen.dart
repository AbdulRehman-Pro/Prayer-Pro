import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/api_service.dart';
import '../../utils/color_res.dart';
import '../../utils/svg_res.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ApiService _apiService = ApiService();

  @override
  void initState() {

    _fetchPrayers();
    super.initState();
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
            padding: const EdgeInsets.only(left: 20, right: 20,top: 70),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                          "Mecca, Saudi Arabia",
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            "12:10",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 50),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Asr less than ",
                                style: GoogleFonts.inter(
                                  color: Colors.black45,
                                  fontSize: 14.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              TextSpan(
                                text: "6h 3m",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      SvgRes.svgFullMosque,
                      height: 110,
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Date",
                      style: GoogleFonts.inter(
                          color: Colors.black45,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                      ),),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 1,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(100)
                      ),
                    )
                  ],
                ),

                Text(
                  "17 Jumada Al-Awwal 1445",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      height: 2,
                      fontSize: 20),
                ),
                Text(
                  "Sat, 01 Dec 2024",
                  style: GoogleFonts.inter(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )

              ],
            )),
      ),
    );
  }
  void _fetchPrayers() async {
    try {
      dynamic posts = await _apiService.fetchPrayers(date: "1-03-2024", latitude: 31.53472296326869, longitude: 74.31115185474322, school: 1);
      print('Fetched Posts: $posts');
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}
