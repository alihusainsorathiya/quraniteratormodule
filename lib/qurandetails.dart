import 'package:flutter/material.dart';
import 'package:qurantest/logger.dart';
import 'package:qurantest/models/qurantracker.dart';

class QuranDetail extends StatefulWidget {
  final Tracker tracker;
  final List<String> ayats;

  const QuranDetail({Key? key, required this.tracker, required this.ayats})
      : super(key: key);

  @override
  State<QuranDetail> createState() => _QuranDetailState();
}

class _QuranDetailState extends State<QuranDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayats to be recited"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: widget.ayats.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        color: (index % 2 == 0) ? Colors.blue : Colors.white,
                        child: Text(
                          widget.ayats[index].toString(),
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
        widget.tracker.ayatCurrentOffset);
    // widget.tracker.totalayatsfromNextSurah = 0;
    // widget.tracker.ayatsAskedByUser = 0;

    widget.ayats.clear();
    Log("Count Resetted: " + widget.ayats.length.toString());
  }

  void saveProgressToDB() {}
}
