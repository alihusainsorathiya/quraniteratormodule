import 'package:qurantest/logger.dart';

class Tracker {
  int? currentAyatNumber = 0,
      ayatsAskedByUser = 0,
      currentSurahNumber = 0,
      totalayatsfromNextSurah = 0,
      ayatsReadByUser = 0,
      previousSurahNumber = 0;

  Tracker({
    this.currentAyatNumber,
    this.ayatsAskedByUser,
    this.currentSurahNumber,
    this.totalayatsfromNextSurah,
    this.ayatsReadByUser,
    this.previousSurahNumber,
  });

  Tracker.fromJson(Map<String, dynamic> json) {
    currentAyatNumber = json['currentAyatNumber'];
    ayatsAskedByUser = json['ayatsAskedByUser'];
    currentSurahNumber = json['currentSurahNumber'];
    totalayatsfromNextSurah = json['totalayatsfromNextSurah'];
    ayatsReadByUser = json['ayatCurrentOffset'];
    previousSurahNumber = json['previousSurahNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentAyatNumber'] = currentAyatNumber;
    data['ayatsAskedByUser'] = ayatsAskedByUser;
    data['currentSurahNumber'] = currentSurahNumber;
    data['totalayatsfromNextSurah'] = totalayatsfromNextSurah;
    data['ayatCurrentOffset'] = ayatsReadByUser;
    data['previousSurahNumber'] = previousSurahNumber;

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

  Tracker.print2() {
    Log("=========== Printing2 Tracker Values ===========");

    Log('currentAyatNumber: ' + currentAyatNumber.toString());
    Log('ayatsAskedByUser: ' + ayatsAskedByUser.toString());
    Log('currentSurahNumber: ' + currentSurahNumber.toString());
    Log('totalayatsfromNextSurah: ' + totalayatsfromNextSurah.toString());
    Log('ayatsReadByUser: ' + ayatsReadByUser.toString());
    Log("previousSurahNumber" + previousSurahNumber.toString());
    Log("==============================================");
  }
}
