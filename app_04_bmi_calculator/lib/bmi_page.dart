import 'dart:math';

import 'package:app_04_bmi_calculator/weight_button.dart';
import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double weight = 80.0;
  double height = 170.0;

  double calculateBMI() {
    final bmi = weight / (pow(height / 100, 2));
    return bmi;
  }

  String bmiStatus() {
    final bmi = calculateBMI();
    if (bmi < 18.5) {
      return "Underweight";
    }
    if (bmi < 25) {
      return "Healthy";
    }
    if (bmi < 30) {
      return "Overweight";
    }
    return "Obesity";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: BoxBorder.all(color: Colors.grey, width: 1),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        calculateBMI().toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        bmiStatus(),
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WeightButton(
                      icon: Icons.remove,
                      size: "big",
                      onTap: () => setState(() {
                        weight -= 2;
                      }),
                    ),
                    WeightButton(
                      icon: Icons.remove,
                      size: "small",
                      onTap: () => setState(() {
                        weight -= 0.5;
                      }),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${weight}kg',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    WeightButton(
                      icon: Icons.add,
                      size: "small",
                      onTap: () => setState(() {
                        weight += 0.5;
                      }),
                    ),
                    WeightButton(
                      icon: Icons.add,
                      size: "big",
                      onTap: () => setState(() {
                        weight += 2;
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Slider(
                        min: 120,
                        max: 220,
                        value: height,
                        onChanged: (value) => setState(() {
                          height = value;
                        }),
                      ),
                    ),

                    SizedBox(width: 6),

                    Text(
                      '${height.toStringAsFixed(0)} cm',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
