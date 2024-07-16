class PaymentDetailModel {
  List<Paymenthistory>? paymenthistory;
  List<MisDetails>? misDetails;
  List<Type>? type;
  List<GateWay>? gateWay;
  List<STUDENTPAYMENTDETAILS>? sTUDENTPAYMENTDETAILS;

  PaymentDetailModel(
      {this.paymenthistory,
      this.misDetails,
      this.type,
      this.gateWay,
      this.sTUDENTPAYMENTDETAILS});

  PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['paymenthistory'] != null) {
      paymenthistory = <Paymenthistory>[];
      json['paymenthistory'].forEach((v) {
        paymenthistory!.add(Paymenthistory.fromJson(v));
      });
    }
    if (json['misDetails'] != null) {
      misDetails = <MisDetails>[];
      json['misDetails'].forEach((v) {
        misDetails!.add(MisDetails.fromJson(v));
      });
    }
    if (json['type'] != null) {
      type = <Type>[];
      json['type'].forEach((v) {
        type!.add(Type.fromJson(v));
      });
    }
    if (json['gateWay'] != null) {
      gateWay = <GateWay>[];
      json['gateWay'].forEach((v) {
        gateWay!.add(GateWay.fromJson(v));
      });
    }
    if (json['STUDENTPAYMENTDETAILS'] != null) {
      sTUDENTPAYMENTDETAILS = <STUDENTPAYMENTDETAILS>[];
      json['STUDENTPAYMENTDETAILS'].forEach((v) {
        sTUDENTPAYMENTDETAILS!.add(STUDENTPAYMENTDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymenthistory != null) {
      data['paymenthistory'] = paymenthistory!.map((v) => v.toJson()).toList();
    }
    if (misDetails != null) {
      data['misDetails'] = misDetails!.map((v) => v.toJson()).toList();
    }
    if (type != null) {
      data['type'] = type!.map((v) => v.toJson()).toList();
    }
    if (gateWay != null) {
      data['gateWay'] = gateWay!.map((v) => v.toJson()).toList();
    }
    if (sTUDENTPAYMENTDETAILS != null) {
      data['STUDENTPAYMENTDETAILS'] =
          sTUDENTPAYMENTDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paymenthistory {
  String? batchName;
  String? studentId;
  String? sRN;
  String? transactionDetails;
  String? transactionNo;
  String? pESReferenceNo;
  String? amount;
  String? transactionDate;
  String? verifiedStatus;
  int? feeType;
  String? studentPaymentTransctionDetailsId;
  String? instId;
  String? paymentType;
  String? sptStatus;
  String? optStatus;
  String? onlinePayment;
  String? st;
  String? academicYearId;
  String? reason;

  Paymenthistory(
      {this.batchName,
      this.studentId,
      this.sRN,
      this.transactionDetails,
      this.transactionNo,
      this.pESReferenceNo,
      this.amount,
      this.transactionDate,
      this.verifiedStatus,
      this.feeType,
      this.studentPaymentTransctionDetailsId,
      this.instId,
      this.paymentType,
      this.sptStatus,
      this.optStatus,
      this.onlinePayment,
      this.st,
      this.academicYearId,
      this.reason});

  Paymenthistory.fromJson(Map<String, dynamic> json) {
    batchName = json['BatchName'];
    studentId = json['StudentId'];
    sRN = json['SRN'];
    transactionDetails = json['TransactionDetails'];
    transactionNo = json['TransactionNo'];
    pESReferenceNo = json['PESReferenceNo'];
    amount = json['Amount'];
    transactionDate = json['TransactionDate'];
    verifiedStatus = json['VerifiedStatus'];
    feeType = json['FeeType'];
    studentPaymentTransctionDetailsId =
        json['StudentPaymentTransctionDetailsId'];
    instId = json['InstId'];
    paymentType = json['PaymentType'];
    sptStatus = json['sptStatus'];
    optStatus = json['optStatus'];
    onlinePayment = json['OnlinePayment'];
    st = json['St'];
    academicYearId = json['AcademicYearId'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BatchName'] = batchName;
    data['StudentId'] = studentId;
    data['SRN'] = sRN;
    data['TransactionDetails'] = transactionDetails;
    data['TransactionNo'] = transactionNo;
    data['PESReferenceNo'] = pESReferenceNo;
    data['Amount'] = amount;
    data['TransactionDate'] = transactionDate;
    data['VerifiedStatus'] = verifiedStatus;
    data['FeeType'] = feeType;
    data['StudentPaymentTransctionDetailsId'] =
        studentPaymentTransctionDetailsId;
    data['InstId'] = instId;
    data['PaymentType'] = paymentType;
    data['sptStatus'] = sptStatus;
    data['optStatus'] = optStatus;
    data['OnlinePayment'] = onlinePayment;
    data['St'] = st;
    data['AcademicYearId'] = academicYearId;
    data['Reason'] = reason;
    return data;
  }
}

class MisDetails {
  int? studentPaymentTransctionDetailsId;
  String? sRN;
  String? remitterBankName;
  String? transactionDetails;
  String? transactionNo;
  String? amount;
  String? transactionDate;
  int? academicYearId;
  String? batchName;
  String? verifiedStatus;
  int? recepitId;
  int? allowDownloadReceipt;
  int? printStatus;

  MisDetails(
      {this.studentPaymentTransctionDetailsId,
      this.sRN,
      this.remitterBankName,
      this.transactionDetails,
      this.transactionNo,
      this.amount,
      this.transactionDate,
      this.academicYearId,
      this.batchName,
      this.verifiedStatus,
      this.recepitId,
      this.allowDownloadReceipt,
      this.printStatus});

  MisDetails.fromJson(Map<String, dynamic> json) {
    studentPaymentTransctionDetailsId =
        json['StudentPaymentTransctionDetailsId'];
    sRN = json['SRN'];
    remitterBankName = json['RemitterBankName'];
    transactionDetails = json['TransactionDetails'];
    transactionNo = json['TransactionNo'];
    amount = json['Amount'];
    transactionDate = json['TransactionDate'];
    academicYearId = json['AcademicYearId'];
    batchName = json['BatchName'];
    verifiedStatus = json['VerifiedStatus'];
    recepitId = json['RecepitId'];
    allowDownloadReceipt = json['AllowDownloadReceipt'];
    printStatus = json['PrintStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StudentPaymentTransctionDetailsId'] =
        studentPaymentTransctionDetailsId;
    data['SRN'] = sRN;
    data['RemitterBankName'] = remitterBankName;
    data['TransactionDetails'] = transactionDetails;
    data['TransactionNo'] = transactionNo;
    data['Amount'] = amount;
    data['TransactionDate'] = transactionDate;
    data['AcademicYearId'] = academicYearId;
    data['BatchName'] = batchName;
    data['VerifiedStatus'] = verifiedStatus;
    data['RecepitId'] = recepitId;
    data['AllowDownloadReceipt'] = allowDownloadReceipt;
    data['PrintStatus'] = printStatus;
    return data;
  }
}

class Type {
  int? miscellaneousPaymentTypeId;
  String? miscellaneousPaymentType;

  Type({this.miscellaneousPaymentTypeId, this.miscellaneousPaymentType});

  Type.fromJson(Map<String, dynamic> json) {
    miscellaneousPaymentTypeId = json['MiscellaneousPaymentTypeId'];
    miscellaneousPaymentType = json['MiscellaneousPaymentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MiscellaneousPaymentTypeId'] = miscellaneousPaymentTypeId;
    data['MiscellaneousPaymentType'] = miscellaneousPaymentType;
    return data;
  }
}

class GateWay {
  int? gateWayCount;
  int? gateWayTypeId;

  GateWay({this.gateWayCount, this.gateWayTypeId});

  GateWay.fromJson(Map<String, dynamic> json) {
    gateWayCount = json['GateWayCount'];
    gateWayTypeId = json['GateWayTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GateWayCount'] = gateWayCount;
    data['GateWayTypeId'] = gateWayTypeId;
    return data;
  }
}

class STUDENTPAYMENTDETAILS {
  String? demandId;
  String? sRN;
  String? loginId;
  String? name;
  String? lastName;
  int? academicYearId;
  String? academicYear;
  String? userId;
  double? demandAmount;
  double? paidAmount;
  double? amount;
  int? isApproved;
  String? instituteName;
  int? instId;
  String? program;
  int? programId;
  String? branch;
  int? branchId;
  int? quota;
  int? batchId;
  String? batch;
  String? instKey;
  String? email;
  String? verifiedStatus;
  int? noofTransction;
  String? feetype;
  double? dueAmount;
  String? mobile;
  double? cetAmnt;
  int? printStatus;
  double? minAmount;
  dynamic startDate;
  int? isEnabled;
  int? latestStudentsStartDate;
  dynamic latestStudentsEndDate;
  int? noOfDays;
  int? estFineAmount;
  String? finDemandFeeType;
  String? finDemandFeeTypeId;
  int? status;
  String? dueDate;
  String? transactionDate;
  String? paymentStatus;
  String? paymentKey;
  double? otherMinAmount;
  double? totalDue;

  STUDENTPAYMENTDETAILS({
    this.demandId,
    this.sRN,
    this.loginId,
    this.name,
    this.lastName,
    this.academicYearId,
    this.academicYear,
    this.userId,
    this.demandAmount,
    this.paidAmount,
    this.amount,
    this.isApproved,
    this.instituteName,
    this.instId,
    this.program,
    this.programId,
    this.branch,
    this.branchId,
    this.quota,
    this.batchId,
    this.batch,
    this.instKey,
    this.email,
    this.verifiedStatus,
    this.noofTransction,
    this.feetype,
    this.dueAmount,
    this.mobile,
    this.cetAmnt,
    this.printStatus,
    this.minAmount,
    this.startDate,
    this.isEnabled,
    this.latestStudentsStartDate,
    this.latestStudentsEndDate,
    this.noOfDays,
    this.estFineAmount,
    this.finDemandFeeType,
    this.finDemandFeeTypeId,
    this.status,
    this.dueDate,
    this.transactionDate,
    this.paymentStatus,
    this.paymentKey,
    this.otherMinAmount,
    this.totalDue,
  });

  STUDENTPAYMENTDETAILS.fromJson(Map<String, dynamic> json) {
    demandId = json['DemandId'];
    sRN = json['SRN'];
    loginId = json['LoginId'];
    name = json['Name'];
    lastName = json['LastName'];
    academicYearId = json['AcademicYearId'];
    academicYear = json['AcademicYear'];
    userId = json['UserId'];
    demandAmount = json['DemandAmount'];
    paidAmount = json['PaidAmount'];
    amount = json['Amount'];
    isApproved = json['IsApproved'];
    instituteName = json['InstituteName'];
    instId = json['InstId'];
    program = json['Program'];
    programId = json['ProgramId'];
    branch = json['Branch'];
    branchId = json['BranchId'];
    quota = json['Quota'];
    batchId = json['BatchId'];
    batch = json['Batch'];
    instKey = json['InstKey'];
    email = json['Email'];
    verifiedStatus = json['VerifiedStatus'];
    noofTransction = json['NoofTransction'];
    feetype = json['Feetype'];
    dueAmount = json['DueAmount'];
    mobile = json['Mobile'];
    cetAmnt = json['cetAmnt'];
    printStatus = json['PrintStatus'];
    minAmount = json['MinAmount'];
    startDate = json['StartDate'];
    isEnabled = json['IsEnabled'];
    latestStudentsStartDate = json['LatestStudents_StartDate'];
    latestStudentsEndDate = json['LatestStudents_EndDate'];
    noOfDays = json['NoOfDays'];
    estFineAmount = json['EstFineAmount'];
    finDemandFeeType = json['finDemandFeeType'];
    finDemandFeeTypeId = json['finDemandFeeTypeId'];
    status = json['Status'];
    dueDate = json['DueDate'];
    transactionDate = json['TransactionDate'];
    paymentStatus = json['paymentStatus'];
    paymentKey = json['paymentKey'];
    otherMinAmount = json['otherMinAmount'];
    totalDue=json['TotalDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DemandId'] = demandId;
    data['SRN'] = sRN;
    data['LoginId'] = loginId;
    data['Name'] = name;
    data['LastName'] = lastName;
    data['AcademicYearId'] = academicYearId;
    data['AcademicYear'] = academicYear;
    data['UserId'] = userId;
    data['DemandAmount'] = demandAmount;
    data['PaidAmount'] = paidAmount;
    data['Amount'] = amount;
    data['IsApproved'] = isApproved;
    data['InstituteName'] = instituteName;
    data['InstId'] = instId;
    data['Program'] = program;
    data['ProgramId'] = programId;
    data['Branch'] = branch;
    data['BranchId'] = branchId;
    data['Quota'] = quota;
    data['BatchId'] = batchId;
    data['Batch'] = batch;
    data['InstKey'] = instKey;
    data['Email'] = email;
    data['VerifiedStatus'] = verifiedStatus;
    data['NoofTransction'] = noofTransction;
    data['Feetype'] = feetype;
    data['DueAmount'] = dueAmount;
    data['Mobile'] = mobile;
    data['cetAmnt'] = cetAmnt;
    data['PrintStatus'] = printStatus;
    data['MinAmount'] = minAmount;
    data['StartDate'] = startDate;
    data['IsEnabled'] = isEnabled;
    data['LatestStudents_StartDate'] = latestStudentsStartDate;
    data['LatestStudents_EndDate'] = latestStudentsEndDate;
    data['NoOfDays'] = noOfDays;
    data['EstFineAmount'] = estFineAmount;
    data['finDemandFeeType'] = finDemandFeeType;
    data['finDemandFeeTypeId'] = finDemandFeeTypeId;
    data['Status'] = status;
    data['DueDate'] = dueDate;
    data['TransactionDate'] = transactionDate;
    data['paymentStatus'] = paymentStatus;
    data['paymentKey'] = paymentKey;
    data['otherMinAmount'] = otherMinAmount;
    data['TotalDue']=totalDue;
    return data;
  }
}
