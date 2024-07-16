class STypeModel {
  List<Stype>? stype;

  STypeModel({this.stype});

  STypeModel.fromJson(Map<String, dynamic> json) {
    if (json['stype'] != null) {
      stype = <Stype>[];
      json['stype'].forEach((v) {
        stype!.add( Stype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stype != null) {
      data['stype'] = stype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stype {
  int? id;
  String? name;

  Stype({this.id, this.name});

  Stype.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
