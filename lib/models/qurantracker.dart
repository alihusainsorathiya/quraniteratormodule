import 'package:qurantest/logger.dart';

class Tracker {
  int? currentAyatNumber = 0,
      ayatsAskedByUser = 0,
      currentSurahNumber = 0,
      totalayatsfromNextSurah = 0,
      ayatCurrentOffset = 0;

  Tracker(
      {this.currentAyatNumber,
      this.ayatsAskedByUser,
      this.currentSurahNumber,
      this.totalayatsfromNextSurah,
      this.ayatCurrentOffset});

  Tracker.fromJson(Map<String, dynamic> json) {
    currentAyatNumber = json['currentAyatNumber'];
    ayatsAskedByUser = json['ayatsAskedByUser'];
    currentSurahNumber = json['currentSurahNumber'];
    totalayatsfromNextSurah = json['totalayatsfromNextSurah'];
    ayatCurrentOffset = json['ayatCurrentOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentAyatNumber'] = currentAyatNumber;
    data['ayatsAskedByUser'] = ayatsAskedByUser;
    data['currentSurahNumber'] = currentSurahNumber;
    data['totalayatsfromNextSurah'] = totalayatsfromNextSurah;
    data['ayatCurrentOffset'] = ayatCurrentOffset;
    return data;
  }

  Tracker.print(
      int? currentAyatNumber,
      int? ayatsAskedByUser,
      int? currentSurahNumber,
      int? totalayatsfromNextSurah,
      int? ayatCurrentOffset) {
    Log("=========== Printing Tracker Values ===========");
    Log('currentAyatNumber: ' + currentAyatNumber.toString());
    Log('ayatsAskedByUser: ' + ayatsAskedByUser.toString());
    Log('currentSurahNumber: ' + currentSurahNumber.toString());
    Log('totalayatsfromNextSurah: ' + totalayatsfromNextSurah.toString());
    Log('ayatCurrentOffset: ' + ayatCurrentOffset.toString());
    Log("==============================================");
  }
}
