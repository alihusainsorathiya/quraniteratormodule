// import 'package:shared_preferences/shared_preferences.dart';

// import 'logger.dart';

// class SharedPrefs {
//   setInt(String keyValue, int value) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setInt(keyValue, value);
//     Log('Saved $keyValue : $value');
//   }

//   getIntValuesSF(String keyValue) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //Return int
//     int? intValue = prefs.getInt(keyValue);
//     Log('Fetched $keyValue : $intValue');
//     return intValue;
//   }
// }
