

import 'dart:convert';

class ZoneList{
  static final String id = 'ID';
  static final String country = 'Country';
  static final String zone = 'Zone';

  static List<String> getZones() => [id, country, zone];
}

class Zone {
  final int? id;
  final String? country;
  final int? zone;

  const Zone({
    this.id,
    this.country,
    this.zone,
  });

  static Zone fromJson(Map<String, dynamic> json) => Zone(
    id: jsonDecode(json[ZoneList.id]),
    country: json[ZoneList.country],
    zone: jsonDecode(json[ZoneList.zone]),
  );

  Map<String, dynamic> toJson() => {
    ZoneList.id: id,
    ZoneList.country: country,
    ZoneList.zone: zone,

  };
}