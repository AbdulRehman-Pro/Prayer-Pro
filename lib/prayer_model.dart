// To parse this JSON data, do
//
//     final prayerModel = prayerModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

PrayerModel prayerModelFromJson(String str) =>
    PrayerModel.fromJson(json.decode(str));

String prayerModelToJson(PrayerModel data) => json.encode(data.toJson());

class PrayerModel {
  int? code;
  String? status;
  Data? data;

  PrayerModel({
    this.code,
    this.status,
    this.data,
  });

  factory PrayerModel.fromJson(Map<String, dynamic> json) => PrayerModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Timings? timings;
  Date? date;
  Meta? meta;

  Data({
    this.timings,
    this.date,
    this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timings: Timings.fromJson(json["timings"]),
        date: Date.fromJson(json["date"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "timings": timings!.toJson(),
        "date": date!.toJson(),
        "meta": meta!.toJson(),
      };
}

class Date {
  String? readable;
  String? timestamp;
  Hijri? hijri;
  Gregorian? gregorian;

  Date({
    this.readable,
    this.timestamp,
    this.hijri,
    this.gregorian,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json["readable"],
        timestamp: json["timestamp"],
        hijri: Hijri.fromJson(json["hijri"]),
        gregorian: Gregorian.fromJson(json["gregorian"]),
      );

  Map<String, dynamic> toJson() => {
        "readable": readable,
        "timestamp": timestamp,
        "hijri": hijri!.toJson(),
        "gregorian": gregorian!.toJson(),
      };
}

class Gregorian {
  String? date;
  String? format;
  String? day;
  GregorianWeekday? weekday;
  GregorianMonth? month;
  String? year;
  Designation? designation;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: GregorianWeekday.fromJson(json["weekday"]),
        month: GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday!.toJson(),
        "month": month!.toJson(),
        "year": year,
        "designation": designation!.toJson(),
      };

  String get formattedDate {
    return formatGregorianDate(date!);
  }
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({
    this.abbreviated,
    this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json["abbreviated"],
        expanded: json["expanded"],
      );

  Map<String, dynamic> toJson() => {
        "abbreviated": abbreviated,
        "expanded": expanded,
      };
}

class GregorianMonth {
  int? number;
  String? en;

  GregorianMonth({
    this.number,
    this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
      };
}

class GregorianWeekday {
  String? en;

  GregorianWeekday({
    this.en,
  });

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      GregorianWeekday(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Hijri {
  String? date;
  String? format;
  String? day;
  HijriWeekday? weekday;
  HijriMonth? month;
  String? year;
  Designation? designation;
  List<dynamic>? holidays;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: HijriWeekday.fromJson(json["weekday"]),
        month: HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
        holidays: List<dynamic>.from(json["holidays"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday!.toJson(),
        "month": month!.toJson(),
        "year": year,
        "designation": designation!.toJson(),
        "holidays": List<dynamic>.from(holidays!.map((x) => x)),
      };

  String get formattedDate {
    return "$day ${month!.en} $year";
  }
}

class HijriMonth {
  int? number;
  String? en;
  String? ar;

  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
        "ar": ar,
      };
}

class HijriWeekday {
  String? en;
  String? ar;

  HijriWeekday({
    this.en,
    this.ar,
  });

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
      };
}

class Meta {
  double? latitude;
  double? longitude;
  String? timezone;
  Method? method;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;
  Map<String, int>? offset;

  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timezone: json["timezone"],
        method: Method.fromJson(json["method"]),
        latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"],
        midnightMode: json["midnightMode"],
        school: json["school"],
        offset:
            Map.from(json["offset"]).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "timezone": timezone,
        "method": method!.toJson(),
        "latitudeAdjustmentMethod": latitudeAdjustmentMethod,
        "midnightMode": midnightMode,
        "school": school,
        "offset":
            Map.from(offset!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Method {
  int? id;
  String? name;
  Params? params;
  Location? location;

  Method({
    this.id,
    this.name,
    this.params,
    this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        name: json["name"],
        params: Params.fromJson(json["params"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "params": params!.toJson(),
        "location": location!.toJson(),
      };
}

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Params {
  int? fajr;
  int? isha;

  Params({
    this.fajr,
    this.isha,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        fajr: json["Fajr"],
        isha: json["Isha"],
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Isha": isha,
      };
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: json["Imsak"],
        midnight: json["Midnight"],
        firstthird: json["Firstthird"],
        lastthird: json["Lastthird"],
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
        "Firstthird": firstthird,
        "Lastthird": lastthird,
      };

  Map<String, dynamic> toPrayerJson() => {
        "Fajr": fajr,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Maghrib": maghrib,
        "Isha": isha,
      };

  Map<String, String?> getNextPrayer(DateTime currentTime) {
    Map<String, String?> nextPrayer = {};
    List<String?> prayerTimes = [fajr, dhuhr, asr, maghrib, isha];
    List<String> prayerNames = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];

    // Format the current time in 24-hour format
    String formattedCurrentTime = DateFormat('HH:mm').format(currentTime);
    DateTime parsedCurrentTime =
        DateFormat('HH:mm').parse(formattedCurrentTime);

    for (int i = 0; i < prayerTimes.length; i++) {
      String? prayerTime = prayerTimes[i];
      if (prayerTime != null) {
        try {
          // Parse the prayer time into a DateTime object
          DateTime parsedPrayerTime = DateFormat('HH:mm').parse(prayerTime);

          // Format the parsed prayer time back to a string
          String formattedPrayerTime =
              DateFormat('HH:mm').format(parsedPrayerTime);

          // Compare the formatted current time with the formatted prayer time
          if (formattedPrayerTime.compareTo(formattedCurrentTime) > 0) {
            nextPrayer[prayerNames[i]] = prayerTime;
            // Calculate the time difference
            Duration timeDifference =
                parsedPrayerTime.difference(parsedCurrentTime);
            nextPrayer['TimeDifference'] = formatTimeDifference(timeDifference);
            break;
          }
        } catch (e) {
          debugPrint('Error parsing prayer time: $e');
        }
      }
    }

    return nextPrayer;
  }

  String formatTimeDifference(Duration difference) {
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}

class PrayerTimings {
  String fajr;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;

  PrayerTimings({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
}

String formatGregorianDate(String dateString) {
  // Split the date string into day, month, and year
  List<String> parts = dateString.split('-');
  String day = parts[0];
  String month = parts[1];
  String year = parts[2];

  // Convert month number to its abbreviation
  Map<String, String> monthAbbreviations = {
    '01': 'Jan',
    '02': 'Feb',
    '03': 'Mar',
    '04': 'Apr',
    '05': 'May',
    '06': 'Jun',
    '07': 'Jul',
    '08': 'Aug',
    '09': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };

  String? monthAbbreviation = monthAbbreviations[month];

  // Format the date as "Tue, 12 Mar 2024"
  DateTime dateTime =
      DateTime(int.parse(year), int.parse(month), int.parse(day));
  String weekday =
      DateFormat('EEE').format(dateTime); // Get weekday abbreviation
  return '$weekday, $day $monthAbbreviation $year';
}

class Prayer {
  final String name;
  final String time;

  Prayer({required this.name, required this.time});
}

//
// class PrayerResponse {
//   final int code;
//   final String status;
//   final PrayerData data;
//   final Meta meta;
//
//   PrayerResponse({required this.code, required this.status, required this.data, required this.meta});
//
//   factory PrayerResponse.fromJson(Map<String, dynamic> json) {
//     return PrayerResponse(
//       code: json['code'],
//       status: json['status'],
//       data: PrayerData.fromJson(json['data']),
//       meta: Meta.fromJson(json['meta']),
//     );
//   }
// }
//
//
// // class PrayerData {
// //   final Map<String, String> timings;
// //   final PrayerDate date;
// //
// //   PrayerData({required this.timings, required this.date});
// //
// //   factory PrayerData.fromJson(Map<String, dynamic> json) {
// //     return PrayerData(
// //       timings: (json['timings'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value.toString())),
// //       date: PrayerDate.fromJson(json['date']),
// //     );
// //   }
// // }
//
// class PrayerData {
//   final Map<String, String> timings;
//   final PrayerDate date;
//
//   PrayerData({required this.timings, required this.date});
//
//   factory PrayerData.fromJson(Map<String, dynamic> json) {
//     Map<String, String> timings = {};
//
//     if (json['timings'] != null && json['timings'] is Map<String, dynamic>) {
//       json['timings'].forEach((key, value) {
//         if (value is String) {
//           timings[key] = value;
//         } else if (value is Map<String, dynamic>) {
//           timings[key] = value.toString();
//         }
//       });
//     }
//
//     return PrayerData(
//       timings: timings,
//       date: PrayerDate.fromJson(json['date']),
//     );
//   }
// }
//
//
//
// class PrayerDate {
//   final String readable;
//   final String timestamp;
//   final Hijri hijri;
//   final Gregorian gregorian;
//
//   PrayerDate({required this.readable, required this.timestamp, required this.hijri, required this.gregorian});
//
//   factory PrayerDate.fromJson(Map<String, dynamic> json) {
//     return PrayerDate(
//       readable: json['readable'],
//       timestamp: json['timestamp'],
//       hijri: Hijri.fromJson(json['hijri']),
//       gregorian: Gregorian.fromJson(json['gregorian']),
//     );
//   }
// }
//
// class Hijri {
//   final String date;
//   final String format;
//   final String day;
//   final Map<String, String> weekday;
//   final Map<String, String> month;
//   final String year;
//   final Designation designation;
//   final List<dynamic> holidays;
//
//   Hijri({
//     required this.date,
//     required this.format,
//     required this.day,
//     required this.weekday,
//     required this.month,
//     required this.year,
//     required this.designation,
//     required this.holidays,
//   });
//
//   factory Hijri.fromJson(Map<String, dynamic> json) {
//     return Hijri(
//       date: json['date'],
//       format: json['format'],
//       day: json['day'],
//       weekday: json['weekday'],
//       month: json['month'],
//       year: json['year'],
//       designation: Designation.fromJson(json['designation']),
//       holidays: json['holidays'],
//     );
//   }
// }
//
// class Gregorian {
//   final String date;
//   final String format;
//   final String day;
//   final Map<String, String> weekday;
//   final Map<String, String> month;
//   final String year;
//   final Designation designation;
//
//   Gregorian({
//     required this.date,
//     required this.format,
//     required this.day,
//     required this.weekday,
//     required this.month,
//     required this.year,
//     required this.designation,
//   });
//
//   factory Gregorian.fromJson(Map<String, dynamic> json) {
//     return Gregorian(
//       date: json['date'],
//       format: json['format'],
//       day: json['day'],
//       weekday: json['weekday'],
//       month: json['month'],
//       year: json['year'],
//       designation: Designation.fromJson(json['designation']),
//     );
//   }
// }
//
// class Designation {
//   final String abbreviated;
//   final String expanded;
//
//   Designation({required this.abbreviated, required this.expanded});
//
//   factory Designation.fromJson(Map<String, dynamic> json) {
//     return Designation(
//       abbreviated: json['abbreviated'],
//       expanded: json['expanded'],
//     );
//   }
// }
//
// class Meta {
//   final double latitude;
//   final double longitude;
//   final String timezone;
//   final Method method;
//   final String latitudeAdjustmentMethod;
//   final String midnightMode;
//   final String school;
//   final Map<String, int> offset;
//
//   Meta({
//     required this.latitude,
//     required this.longitude,
//     required this.timezone,
//     required this.method,
//     required this.latitudeAdjustmentMethod,
//     required this.midnightMode,
//     required this.school,
//     required this.offset,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) {
//     return Meta(
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       timezone: json['timezone'],
//       method: Method.fromJson(json['method']),
//       latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
//       midnightMode: json['midnightMode'],
//       school: json['school'],
//       offset: (json['offset'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as int)),
//     );
//   }
// }
//
// class Method {
//   final int id;
//   final String name;
//   final Map<String, int> params;
//   final Location location;
//
//   Method({
//     required this.id,
//     required this.name,
//     required this.params,
//     required this.location,
//   });
//
//   factory Method.fromJson(Map<String, dynamic> json) {
//     return Method(
//       id: json['id'],
//       name: json['name'],
//       params: (json['params'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as int)),
//       location: Location.fromJson(json['location']),
//     );
//   }
// }
//
// class Location {
//   final double latitude;
//   final double longitude;
//
//   Location({required this.latitude, required this.longitude});
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//     );
//   }
// }
//
