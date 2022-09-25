import 'dart:convert';

class RateChart{
  static final String id = 'ID';
  static final String weight = 'Weight (Kg)';
  static final String zone1 = 'Zone 1';
  static final String zone2 = 'Zone 2';
  static final String zone3 = 'Zone 3';
  static final String zone4 = 'Zone 4';
  static final String zone5 = 'Zone 5';
  static final String zone6 = 'Zone 6';
  static final String zone7 = 'Zone 7';

  static List<String> getCharts() => [id, weight, zone1, zone2, zone3, zone4, zone5, zone6, zone7];
}

class Rate {
  final int? id;
  final String? weight;
  final double? zone1;
  final double? zone2;
  final double? zone3;
  final double? zone4;
  final double? zone5;
  final double? zone6;
  final double? zone7;

  const Rate({
    this.id,
    this.weight,
    this.zone1,
    this.zone2,
    this.zone3,
    this.zone4,
    this.zone5,
    this.zone6,
    this.zone7,
  });

  static Rate fromJson(Map<String, dynamic> json) => Rate(
    id: jsonDecode(json[RateChart.id]),
    weight: json[RateChart.weight],
    zone1: jsonDecode(json[RateChart.zone1]),
    zone2: jsonDecode(json[RateChart.zone2]),
    zone3: jsonDecode(json[RateChart.zone3]),
    zone4: jsonDecode(json[RateChart.zone4]),
    zone5: jsonDecode(json[RateChart.zone5]),
    zone6: jsonDecode(json[RateChart.zone6]),
    zone7: jsonDecode(json[RateChart.zone7]),
  );

  Map<String, dynamic> toJson() => {
    RateChart.id: id,
    RateChart.weight: weight,
    RateChart.zone1: zone1,
    RateChart.zone2: zone2,
    RateChart.zone3: zone3,
    RateChart.zone4: zone4,
    RateChart.zone5: zone5,
    RateChart.zone6: zone6,
    RateChart.zone7: zone7,
  };
}