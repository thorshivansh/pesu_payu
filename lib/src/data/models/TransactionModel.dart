class TransactionDetailModel {
  List<StudentDetails>? studentDetails;

  TransactionDetailModel({this.studentDetails});

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['StudentDetails'] != null) {
      studentDetails = <StudentDetails>[];
      json['StudentDetails'].forEach((v) {
        studentDetails!.add(new StudentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentDetails != null) {
      data['StudentDetails'] =
          this.studentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDetails {
  String? studentId;
  String? sRN;
  String? transactionDetails;
  String? transactionNo;
  String? amount;
  String? transactionDate;
  int? paymentType;
  String? verifiedStatus;
  String? reason;
  int? recepitId;
  int? printStatus;
  int? feeType;

  StudentDetails(
      {this.studentId,
      this.sRN,
      this.transactionDetails,
      this.transactionNo,
      this.amount,
      this.transactionDate,
      this.paymentType,
      this.verifiedStatus,
      this.reason,
      this.recepitId,
      this.printStatus,
      this.feeType});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'];
    sRN = json['SRN'];
    transactionDetails = json['TransactionDetails'];
    transactionNo = json['TransactionNo'];
    amount = json['Amount'];
    transactionDate = json['TransactionDate'];
    paymentType = json['PaymentType'];
    verifiedStatus = json['VerifiedStatus'];
    reason = json['Reason'];
    recepitId = json['RecepitId'];
    printStatus = json['PrintStatus'];
    feeType = json['FeeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentId'] = this.studentId;
    data['SRN'] = this.sRN;
    data['TransactionDetails'] = this.transactionDetails;
    data['TransactionNo'] = this.transactionNo;
    data['Amount'] = this.amount;
    data['TransactionDate'] = this.transactionDate;
    data['PaymentType'] = this.paymentType;
    data['VerifiedStatus'] = this.verifiedStatus;
    data['Reason'] = this.reason;
    data['RecepitId'] = this.recepitId;
    data['PrintStatus'] = this.printStatus;
    data['FeeType'] = this.feeType;
    return data;
  }
}
