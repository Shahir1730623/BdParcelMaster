import 'dart:convert';

class Ess_Fuel {
  static final String id = 'id';
  static final String ess = 'ess';
  static final String fuel = 'fuel';
  static final String dollar = 'dollar';

  static List<String> getEss_Fuel() => [id, ess, fuel, dollar];
}

class Ess_dollar {
  final int? id;
  final double? ess;
  final double? fuel;
  final double? dollar;

  const Ess_dollar({
    this.id,
    this.ess,
    this.fuel,
    this.dollar,
  });

  static Ess_dollar fromJson(Map<String, dynamic> json) => Ess_dollar(
    id: jsonDecode(json[Ess_Fuel.id]),
    ess: jsonDecode(json[Ess_Fuel.ess]),
    fuel: jsonDecode(json[Ess_Fuel.fuel]),
    dollar: jsonDecode(json[Ess_Fuel.dollar]),
  );

  Map<String, dynamic> toJson() => {
    Ess_Fuel.id: id,
    Ess_Fuel.ess: ess,
    Ess_Fuel.fuel: fuel,
    Ess_Fuel.dollar: dollar,
  };
}