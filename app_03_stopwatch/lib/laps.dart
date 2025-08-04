import 'package:app_03_stopwatch/lap_text.dart';
import 'package:flutter/material.dart';

class Laps extends StatelessWidget {
  final List<List<String>> laps;
  const Laps({super.key, required this.laps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: LapText(text: "Lap")),
            Expanded(child: LapText(text: "Lap Time")),
            Expanded(child: LapText(text: "Overall Time")),
          ],
        ),

        const SizedBox(height: 6),
        const Divider(thickness: 1.0),
        const SizedBox(height: 4),

        Expanded(
          child: ListView.builder(
            itemCount: laps.length,
            itemBuilder: (context, index) {
              final lap = laps[laps.length - index - 1];

              return Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: LapText(text: (laps.length - index).toString()),
                    ),
                    Expanded(child: LapText(text: lap[0])),
                    Expanded(child: LapText(text: lap[1])),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
