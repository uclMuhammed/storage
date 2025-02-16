import 'package:flutter/material.dart';

import '../models/pie_chart_model.dart';

class MyPieChartData {
  static List<PieChartModel> pieChartData = [
    PieChartModel(text: 'ALIM', value: 47, color: Colors.blue),
    PieChartModel(text: 'SATIM', value: 33, color: Colors.red),
    PieChartModel(text: 'ALIM-İADE', value: 12, color: Colors.green),
    PieChartModel(text: 'SATIM-İADE', value: 10, color: Colors.orange),
  ];
}
