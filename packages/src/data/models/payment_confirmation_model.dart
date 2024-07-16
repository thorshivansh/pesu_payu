class PaymentConfirmModel {
  List<Miscellaneouspayment>? miscellaneouspayment;

  PaymentConfirmModel({this.miscellaneouspayment});

  PaymentConfirmModel.fromJson(Map<String, dynamic> json) {
    if (json['miscellaneouspayment'] != null) {
      miscellaneouspayment = <Miscellaneouspayment>[];
      json['miscellaneouspayment'].forEach((v) {
        miscellaneouspayment!.add(Miscellaneouspayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (miscellaneouspayment != null) {
      data['miscellaneouspayment'] =
          miscellaneouspayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Miscellaneouspayment {
  String? loginId;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? instId;
  int? academicYearId;
  String? academicYear;
  String? amount;
  String? paymentDesc;
  String? instructions;
  int? isMultiples;
  String? label;
  String? dataValue1;
  String? dataValue2;
  String? dataValue3;
  int? paymentValidFromAndTo;
  String? paymentKey;

  Miscellaneouspayment(
      {this.loginId,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.instId,
      this.academicYearId,
      this.academicYear,
      this.amount,
      this.paymentDesc,
      this.instructions,
      this.isMultiples,
      this.label,
      this.dataValue1,
      this.dataValue2,
      this.dataValue3,
      this.paymentValidFromAndTo,
      this.paymentKey});

  Miscellaneouspayment.fromJson(Map<String, dynamic> json) {
    loginId = json['LoginId'];
    userId = json['UserId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    mobile = json['Mobile'];
    instId = json['InstId'];
    academicYearId = json['AcademicYearId'];
    academicYear = json['AcademicYear'];
    amount = json['Amount'];
    paymentDesc = json['PaymentDesc'];
    instructions = json['Instructions'];
    isMultiples = json['IsMultiples'];
    label = json['Label'];
    dataValue1 = json['Data_Value1'];
    dataValue2 = json['Data_Value2'];
    dataValue3 = json['Data_Value3'];
    paymentValidFromAndTo = json['PaymentValidFromAndTo'];
    paymentKey = json['PaymentKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LoginId'] = loginId;
    data['UserId'] = userId;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['Mobile'] = mobile;
    data['InstId'] = instId;
    data['AcademicYearId'] = academicYearId;
    data['AcademicYear'] = academicYear;
    data['Amount'] = amount;
    data['PaymentDesc'] = paymentDesc;
    data['Instructions'] = instructions;
    data['IsMultiples'] = isMultiples;
    data['Label'] = label;
    data['Data_Value1'] = dataValue1;
    data['Data_Value2'] = dataValue2;
    data['Data_Value3'] = dataValue3;
    data['PaymentValidFromAndTo'] = paymentValidFromAndTo;
    data['PaymentKey'] = paymentKey;
    return data;
  }
}