import 'package:flutter/material.dart';
import 'package:qurantest/logger.dart';
import 'package:qurantest/models/quranmodel.dart';
import 'package:qurantest/models/qurantracker.dart';
import 'package:qurantest/widgets/ayatdecoration.dart';
import 'package:qurantest/widgets/styles.dart';

class QuranDetail extends StatefulWidget {
  final Tracker tracker;
  final List<String> ayats;
  final List<Surah>? surahList;

  const QuranDetail(
      {Key? key,
      required this.tracker,
      required this.ayats,
      required this.surahList})
      : super(key: key);

  @override
  State<QuranDetail> createState() => _QuranDetailState();
}

class _QuranDetailState extends State<QuranDetail> {
  double fontSize = 18.0;
  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayats to be recited"),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
              } else if (value == 1) {}
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.settings_outlined,
                      color: Colors.black87,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Settings"),
                  ],
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.black87,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("About"),
                  ],
                ),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.15,
            //   child: Card(
            //     elevation: 8.0,
            //     color: Colors.lightBlue,
            //     child: Row(
            //       children: [
            //         (widget.tracker.currentSurahNumber ==
            //                 widget.tracker.previousSurahNumber)
            //  Text(
            //                 '${widget.tracker.currentSurahNumber} + " "+${widget.surahList![widget.tracker.currentSurahNumber!].name}  ')
            //             : Text(
            //                 '${widget.surahList![widget.tracker.currentSurahNumber!].englishName.toString()} : ${widget.tracker.currentAyatNumber! - widget.tracker.ayatsAskedByUser!} - ${widget.tracker.currentAyatNumber}'),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.ayats.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // height: 30,
                        // color: (index % 2 == 0)
                        //     ? Colors.lightBlueAccent.withOpacity(0.4)
                        //     : Colors.white,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: TextDirection.rtl,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      widget.ayats[index].toString(),
                                      textDirection: TextDirection.rtl,
                                      style: arabicTextStyle(
                                          fontSize, Colors.black87),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: AyatDecoration(
                                      sizeNumbering: 40,
                                      text: (index + 1).toString()),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 50,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(children: [
                                    IconButton(
                                        onPressed: share(index,
                                            widget.ayats[index].toString()),
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          color: Colors.white,
                                        )),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            ElevatedButton(
                child: Text("Mark as Complete".toUpperCase(),
                    style: const TextStyle(fontSize: 14)),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.blue)))),
                onPressed: () => saveData())
          ],
        ),
      ),
    );
  }

  saveData() {
    Log("SaveData");
    // Log(widget.tracker.ayatsAskedByUser);
    // widget.tracker.currentAyatNumber = widget.tracker.totalayatsfromNextSurah;
    // int? offset = widget.tracker.ayatCurrentOffset;
    // widget.tracker.currentAyatNumber = offset;
    // widget.tracker.ayatCurrentOffset = 0;
    // widget.tracker.ayatsAskedByUser = 0;
    // Log(widget.tracker.currentAyatNumber);
    // Log(widget.tracker.currentSurahNumber);

    // Log("  widget.tracker.currentAyatNumber: = " +
    //     widget.tracker.currentAyatNumber.toString());
    // int abc = widget.tracker.totalayatsfromNextSurah!;

    // widget.tracker.currentAyatNumber = abc;
    Log("  widget.tracker.currentAyatNumber: = " +
        widget.tracker.totalayatsfromNextSurah.toString());

    saveProgressToDB();
    resetCount();
    // widget.tracker.currentAyatNumber = 0;
    Navigator.pop(context, widget.tracker);
  }

  void resetCount() {
    Tracker.print(
        widget.tracker.currentAyatNumber,
        widget.tracker.ayatsAskedByUser,
        widget.tracker.currentSurahNumber,
        widget.tracker.totalayatsfromNextSurah,
        widget.tracker.ayatsReadByUser);
    // widget.tracker.totalayatsfromNextSurah = 0;
    // widget.tracker.ayatsAskedByUser = 0;

    widget.ayats.clear();
    Log("Count Resetted: " + widget.ayats.length.toString());
  }

  void saveProgressToDB() {}

  share(int index, String string) {}
}
