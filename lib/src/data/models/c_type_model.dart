class CTypeModel {
  List<Ctype>? ctype;

  CTypeModel({this.ctype});

  CTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['ctype'] != null) {
      ctype = <Ctype>[];
      json['ctype'].forEach((v) {
        ctype!.add(Ctype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ctype != null) {
      data['ctype'] = ctype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ctype {
  int? id;
  String? name;
  int? isDisable;
  String? instId;
  int? miscellaneousPaymentConfigId;

  Ctype(
      {this.id,
      this.name,
      this.isDisable,
      this.instId,
      this.miscellaneousPaymentConfigId});

  Ctype.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isDisable = json['IsDisable'];
    instId = json['InstId'];
    miscellaneousPaymentConfigId = json['MiscellaneousPaymentConfigId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['IsDisable'] = isDisable;
    data['InstId'] = instId;
    data['MiscellaneousPaymentConfigId'] = miscellaneousPaymentConfigId;
    return data;
  }
}
