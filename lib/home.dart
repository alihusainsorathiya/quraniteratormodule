import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qurantest/logger.dart';
import 'package:qurantest/models/quranmodel.dart';
import 'package:qurantest/models/qurantracker.dart';
import 'package:qurantest/qurandetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _myController = TextEditingController();
  // List<Widget> ayatText = [];
  final ayatText = <Widget>[];
  List<String> ayatsToBeRecited = [];
  List<int> ayatOptions = [];
  int initialDropDownValue = 5;
  late QuranModel quranModel;
  Tracker tracker = Tracker(
      ayatsAskedByUser: 0,
      currentAyatNumber: 0,
      currentSurahNumber: 0,
      ayatCurrentOffset: 0,
      totalayatsfromNextSurah: 0);

  @override
  void initState() {
    loadQuranfromJson().then((v) => {quranModel = v});
    ayatOptions = List<int>.generate(20, (index) {
      return (index + 1) * 5;
    });
    super.initState();
  }

  @override
  void dispose() {
    // _myController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Test"),
      ),
      body: Column(children: [
        // TextField(
        //   decoration: const InputDecoration(labelText: "Enter your number"),
        //   keyboardType: TextInputType.number,
        //   inputFormatters: <TextInputFormatter>[
        //     FilteringTextInputFormatter.digitsOnly,
        //   ],
        //   maxLength: 3, // Only numbers can be entered

        //   // controller: _myController,
        // ),

        Center(
          child: DropdownButton(
            // Initial Value
            value: initialDropDownValue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            iconSize: 42,
            underline: const SizedBox(),

            // Array list of items
            items: ayatOptions.map((int items) {
              return DropdownMenuItem(
                value: items,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.25,

                      // margin: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          '$items Ayats',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )),
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (int? newValue) {
              setState(() {
                if (newValue != 0) {
                  initialDropDownValue = newValue!;

                  tracker.ayatsAskedByUser = newValue;
                } else {
                  tracker.ayatsAskedByUser = initialDropDownValue;
                }
              });
            },
          ),
        ),

        ElevatedButton(
          onPressed: (() {
            // int value = int.parse((_myController.text));
            Log("ayats asked : " + tracker.ayatsAskedByUser.toString());
            getAyats(tracker.ayatsAskedByUser!);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => QuranDetail(
                        tracker: tracker,
                        ayats: ayatsToBeRecited,
                      )),
                ));
          }),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: const Center(child: Text('Read Ayats')),
          ),
        ),
        // Column(
        //   children: (hasaskedforAyat == true) ? ayatText : [Container()],
        // ),
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
        //   height: MediaQuery.of(context).size.height * 0.6,
        //   child: ListView.builder(
        //       itemCount: 1,
        //       scrollDirection: Axis.vertical,
        //       itemBuilder: ((context, index) => (true)
        //            Column(
        //               children: ayatText,
        //             )
        //           : const Text("Your ayats will load here"))),
        // ),
      ]),
    );
  }

  getAyats(int ayatsAskedByUser) async {
    debugPrint("Ayats to be recited : " + ayatsAskedByUser.toString());
    tracker.ayatsAskedByUser = ayatsAskedByUser;

    //  checkAyatLength
    checkAyats(quranModel.data!.surahs!, tracker.ayatsAskedByUser!,
        tracker.currentSurahNumber!, tracker.currentAyatNumber!);
    //  if ayat asked by user is less than ayahs.length
  }

  checkAyats(List<Surah> surah, int trackerAyatsAskedByUser,
      int trackerCurrentSurahNumber, int trackerCurrentAyatNumber) {
    tracker.ayatsAskedByUser = trackerAyatsAskedByUser;
    tracker.currentAyatNumber = trackerCurrentAyatNumber;
    tracker.currentSurahNumber = trackerCurrentSurahNumber;

    int remainingAyat =
        (surah[tracker.currentSurahNumber!].ayahs!.length).toInt() -
            (tracker.currentAyatNumber!).toInt();

    int checkNextIteration =
        ((tracker.currentAyatNumber! + tracker.ayatsAskedByUser!));

    if (checkNextIteration > surah[tracker.currentSurahNumber!].ayahs!.length) {
      Log("Next Iteration False");
      assignAyatsFromMultipleSurahs(
          surah, tracker.currentSurahNumber!, tracker.currentAyatNumber!);
    } else
    // if (checkNextIteration <=
    //     surah[tracker.currentSurahNumber!].ayahs!.length)

    {
      Log("Inside check Iteration <=");
      int i = tracker.currentAyatNumber!;
      for (i;
          i < (tracker.ayatsAskedByUser! + tracker.currentAyatNumber!);
          i++) {
        ayatsToBeRecited.add(i.toString() +
            " " +
            surah[tracker.currentSurahNumber!].ayahs![i].text.toString());
      }
      Log("Done For Loop : " + tracker.currentAyatNumber!.toString());

      tracker.currentAyatNumber = i;
      Log("After Assigning value of i : " +
          tracker.currentAyatNumber!.toString());

      Tracker.print(
          tracker.currentAyatNumber,
          tracker.ayatsAskedByUser,
          tracker.currentSurahNumber,
          tracker.totalayatsfromNextSurah,
          tracker.ayatCurrentOffset);
      // tracker.ayatsAskedByUser = 0;
      // return ayatText;

    }

    // if (tracker.ayatsAskedByUser! >
    //     ((surah[tracker.currentSurahNumber!].ayahs!.length) -
    //         tracker.currentAyatNumber!)) {
    //   assignAyatsFromMultipleSurahs(
    //       surah, tracker.currentSurahNumber!, tracker.currentAyatNumber!);
    // }

    // if (tracker.ayatsAskedByUser! <=
    //     (surah[tracker.currentSurahNumber!].ayahs!.length -
    //         tracker.currentAyatNumber!)) {

    //     assignAyats(surah);

    // }

    // if (tracker.ayatsAskedByUser! >
    //     (surah[tracker.currentSurahNumber!].ayahs!.length -
    //         tracker.ayatCurrentOffset!)) {
    //   Log("Met the condition");
    //   assignAyatsFromMultipleSurahs(surah, tracker.currentSurahNumber!);
    // }
  }

  assignAyats(List<Surah> surah) {
    tracker.totalayatsfromNextSurah = 0;
    Log("inside (ayatsAskedByUser <= ayats.length)");
    // Log("tracker.currentSurahNumber" + tracker.currentSurahNumber!.toString());
    // tracker.ayatCurrentOffset = tracker.currentAyatNumber;
    // tracker.ayatCurrentOffset =
    //     tracker.currentAyatNumber! + tracker.ayatsAskedByUser!;

    // Log("tracker.ayatCurrentOffset" + tracker.ayatCurrentOffset!.toString());
    int i = tracker.currentAyatNumber!;

    if ((i != null) || (i != 0)) {
      for (i; i < tracker.ayatsAskedByUser!; i++) {
        // ayatText.add(Text(
        //     surah[currentSurahNumber].ayahs![tracker.currentAyatNumber].number.toString() +
        //         " " +
        //         surah[currentSurahNumber].ayahs![tracker.currentAyatNumber].text.toString()));

        ayatsToBeRecited.add(i.toString() +
            " " +
            surah[tracker.currentSurahNumber!].ayahs![i].text.toString());

        // Log(i.toString() +
        //     " " +
        //     surah[tracker.currentSurahNumber!].ayahs![i].number.toString() +
        //     " " +
        //     surah[tracker.currentSurahNumber!].ayahs![i].text.toString());

        // tracker.ayatCurrentOffset = i;
      }
      tracker.currentAyatNumber = i;
    }
    // else {
    //   Log("i==0");
    //   int i = 0;
    // }
    // int ayatNumber = tracker.currentAyatNumber!;
    // tracker.totalayatsfromNextSurah = ayatNumber;

    // setState(() {
    //   tracker.tracker.currentAyatNumber = tracker.currentAyatNumber;
    //   tracker.currentSurahNumber = currentSurahNumber;
    //   tracker.ayatsAskedByUser = ayatsAskedByUser;
    // });

    // tracker.currentAyatNumber = tracker.currentAyatNumber;
    // tracker.currentSurahNumber = currentSurahNumber;
    // tracker.ayatsAskedByUser = ayatsAskedByUser;
    // tracker.currentAyatNumber = tracker.ayatsAskedByUser;
    Log("Added Ayat Offset : " + tracker.currentAyatNumber!.toString());

    Tracker.print(
        tracker.currentAyatNumber,
        tracker.ayatsAskedByUser,
        tracker.currentSurahNumber,
        tracker.totalayatsfromNextSurah,
        tracker.ayatCurrentOffset);
    // tracker.ayatsAskedByUser = 0;
    // return ayatText;
  }

  loadQuranfromJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/quranuthmani.json");
    final jsonResult = jsonDecode(data);
    final quranModel = quranModelFromJson(jsonEncode(jsonResult));
    Log("QuranLoaded");
    return quranModel;
  }

  assignAyatsFromMultipleSurahs(
      List<Surah> surah, int currentSurahNumber, int currentAyahNumber) {
    int trackerCurrentSurahNumber = currentSurahNumber;
    tracker.currentAyatNumber = currentAyahNumber;
    int remainingAyatfromSurah =
        ((surah[trackerCurrentSurahNumber].ayahs!.length).toInt() -
            (tracker.currentAyatNumber!).toInt());

    Log("remainingAyatFroMSurahhhhhh : " + remainingAyatfromSurah.toString());
    Log("inside (ayatsAskedByUser > ayats.length)");
    // int remainingAyatfromSurah =
    //     ((surah[trackerCurrentSurahNumber].ayahs!.length).toInt() -
    //         (tracker.currentAyatNumber!).toInt());
//

    // Log("RemainingAyatFroMSurah::" + remainingAyatfromSurah.toString());

    // for (int i = tracker.currentAyatNumber!;
    //     i < surah[tracker.currentSurahNumber!].ayahs!.length;
    //     i++)

    // for (int i = tracker.currentAyatNumber!;
    //     i <= surah[tracker.currentSurahNumber!].ayahs!.length;
    //     i++)

    for (int i = 0; i < remainingAyatfromSurah; i++) {
      // tracker.currentAyatNumber = tracker.currentAyatNumber! + i;

      ayatsToBeRecited.add((tracker.currentAyatNumber).toString() +
          " " +
          surah[tracker.currentSurahNumber!]
              .ayahs![tracker.currentAyatNumber!]
              .text
              .toString());
      // Log("Remaining Ayats :" +
      //     surah[tracker.currentSurahNumber!].ayahs![i].text.toString());
      tracker.currentAyatNumber = tracker.currentAyatNumber! + 1;
    }
    trackerCurrentSurahNumber++;
    tracker.currentSurahNumber = trackerCurrentSurahNumber;

    // remainingAyatfromSurah--;

    Log("Printing Values to check ======");
    Log("tracker.ayataskedbyuser : " + tracker.ayatsAskedByUser.toString());

    Log("Remaining Ayats : " + remainingAyatfromSurah.toString());
    Log("========================");

    int totalayatsfromNextSurah =
        tracker.ayatsAskedByUser!.toInt() - remainingAyatfromSurah.toInt();

    Log("totalayatsfromnextSurah  before -1: " +
        totalayatsfromNextSurah.toString());
    // totalayatsfromNextSurah--;
    tracker.totalayatsfromNextSurah = totalayatsfromNextSurah;
    // Log(" remainingAyatfromSurah--" + remainingAyatfromSurah.toString());
    Log(" totalayatsfromNextSurah--" + totalayatsfromNextSurah.toString());
    // Log("totalayatsfromNextSurah : " +
    //     totalayatsfromNextSurah.toString() +
    //     "=" +
    //     " tracker.ayatsAskedByUser! - remainingAyatfromSurah" +
    //     tracker.ayatsAskedByUser!.toString() +
    //     "-" +
    //     remainingAyatfromSurah.toString());

    // tracker.totalayatsfromNextSurah = totalayatsfromNextSurah;
    // tracker.ayatCurrentOffset = totalayatsfromNextSurah;

    // Log("tracker.currentSurahNumber" + tracker.currentSurahNumber!.toString());
    int i = 0;
    for (i; i < tracker.totalayatsfromNextSurah!; i++) {
      // ayatText.add(Text(surah[currentSurahNumber].ayahs![i].text.toString()));
      ayatsToBeRecited.add(i.toString() +
          " " +
          surah[trackerCurrentSurahNumber].ayahs![i].text.toString());
      Log("Next Surah Ayats :" +
          surah[trackerCurrentSurahNumber].ayahs![i].text.toString());
    }
    // tracker.currentAyatNumber = tracker.totalayatsfromNextSurah! - 1;
    tracker.currentAyatNumber = i;
    Log("tracker.currentAyatNumber from Multiple surah: -1 " +
        tracker.currentAyatNumber.toString());
  }
}
