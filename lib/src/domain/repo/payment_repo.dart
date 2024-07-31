import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../pesupay.dart';


abstract class PaymentDetailRepo {
  factory PaymentDetailRepo(Dio dio, CancelToken cancelToken) =
      PaymentDetailService;
  Future<Either<Exception, dynamic>> getPaymentDetail(String userId);
  Future<Either<DioException, dynamic>> getTransactionDetail(
      dynamic academicYearId, dynamic feeType, String userId);
  Future<Either<Exception, dynamic>> getDynamicHash({
    required String hash,
    required String txnId,
    required String academicyear,
    required String misctype,
    required String demandId,
    required String dueAmount,
    required String feeName,
    required String fdFeeTypeId,
    required String instId,
    required String merchantKey,
    required String name,
    required String email,
    required String mobileNumber,
    required String userId,
    required String loginId,
  });
  Future<Either<Exception, dynamic>> getCTypeList(int instId);
  Future<Either<Exception, dynamic>> getSTypeList(int id, int instId);
  Future<Either<Exception, dynamic>> getPaymentConfirmationDetail(
      int ctype, int stype, String userId);
  Future<Either<Exception, dynamic>> getPaymenttandc(int instId);
}

class PaymentDetailService implements PaymentDetailRepo {
  PaymentDetailService(this._dio, this._cancelToken);
  final Dio _dio;
  final CancelToken _cancelToken;

  @override
  Future<Either<Exception, dynamic>> getPaymentDetail(String userId) async {
    try {
      log(jsonEncode({
        'action': 48,
        'mode': 1,
        'userId': userId,
      }));
      FormData body = FormData.fromMap({
        'action': 48,
        'mode': 1,
        'userId': userId,
      });

      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'paymentDetail Response');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        return Left(Exception(res.data));
      }
      // return res;
    } on DioException catch (e) {
      log("Error getPaymentDetail", error: e);
      // return false;
      return Left(e);
    }
  }

  @override
  Future<Either<DioException, dynamic>> getTransactionDetail(
      dynamic academicYearId, dynamic feeType, String userId) async {
    try {
      log(jsonEncode({
        'action': 48,
        'mode': 2,
        'userId': userId,
        'academicYear': academicYearId,
        'feeType': feeType
      }));
      FormData body = FormData.fromMap({
        'action': 48,
        'mode': 2,
        'userId': userId,
        'academicYear': academicYearId,
        'feeType': feeType
      });

      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'Transaction Response');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("ERROR getTransactionDetail", error: e);

      return Left(e);
    }
  }

  @override
  Future<Either<Exception, dynamic>> getDynamicHash({
    required String hash,
    required String txnId,
    required String academicyear,
    required String misctype,
    required String demandId,
    required String dueAmount,
    required String feeName,
    required String fdFeeTypeId,
    required String instId,
    required String merchantKey,
    required String name,
    required String email,
    required String mobileNumber,
    required String userId,
    required String loginId,
  }) async {
    log(
        jsonEncode({
          "action": "27",
          "mode": "8",
          "key": merchantKey,
          "txnid": txnId,
          "DueAmount": dueAmount,
          "sname": name,
          "email": email,
          "feename": feeName,
          "instId": instId,
          "UserId": userId,
          "number": mobileNumber,
          "LoginId": loginId,
          "AcademicYear": academicyear,
          "misctype": misctype,
          "fdFeeType": fdFeeTypeId,
          "demandId": demandId,
          "sdkhash": hash,
        }),
        name: 'getDynamicHash formdata');
    try {
      FormData data = FormData.fromMap({
        "action": "27",
        "mode": "8",
        "key": merchantKey,
        "txnid": txnId,
        "DueAmount": dueAmount,
        "sname": name,
        "email": email,
        "feename": feeName,
        "instId": instId,
        "UserId": userId,
        "number": mobileNumber,
        "LoginId": loginId,
        "AcademicYear": academicyear,
        "misctype": misctype,
        "fdFeeType": fdFeeTypeId,
        "demandId": demandId,
        "sdkhash": hash,
      });
      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: data,
      );
      log(res.toString(), name: 'getDynamicHash Hash Response');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("Error getDynamicHash", error: e);
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, dynamic>> getCTypeList(int instId) async {
    try {
      log(jsonEncode({
        'action': 48,
        'mode': 3,
        'instId': instId,
      }));
      FormData body = FormData.fromMap({
        'action': 48,
        'mode': 3,
        'instId': instId,
      });

      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'CType Response');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("error api call in CtypeList", error: e);

      return Left(e);
    }
  }

  @override
  Future<Either<Exception, dynamic>> getSTypeList(int id, int instId) async {
    try {
      log(jsonEncode(
          {'action': 48, 'mode': 4, 'instId': instId, 'id': id, 'type': 0}));
      FormData body = FormData.fromMap({
        'action': 48,
        'mode': 4,
        'instId': instId,
        'id': id,
        'type': 0 // AS FOR NOW IT IS DYNAMIC - RITHESH CONFIRMED
      });

      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'SType Response');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("error api call in StypeList", error: e);

      return Left(e);
    }
  }

  @override
  Future<Either<Exception, dynamic>> getPaymentConfirmationDetail(
      int ctype, int stype, String userId) async {
    try {
      log(jsonEncode({
        'action': 48,
        'mode': 5,
        'userId': userId,
        'subtype': stype,
        'type': ctype,
        "feeType": 2
      }));
      FormData body = FormData.fromMap({
        'action': 48,
        'mode': 5,
        'userId': userId,
        'subtype': stype,
        'type': ctype,
        "feeType": 2
      });

      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'getPaymentConfirmationDetail');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("error api call in getPaymentConfirmationDetail", error: e);
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, dynamic>> getPaymenttandc(int instId) async {
    try {
      log(jsonEncode({'action': 48, 'mode': 6, "instId": instId}));

      FormData body =
          FormData.fromMap({'action': 48, 'mode': 6, "instId": instId});
      var res = await _dio.post(
        ApiConfig.dispatecher,
        data: body,
        cancelToken: _cancelToken,
      );
      log(res.toString(), name: 'getPaymenttandc');
      if (res.statusCode == 200) {
        return Right(res.data);
      } else {
        throw Exception("${res.statusMessage}");
      }
    } on DioException catch (e) {
      log("error api call in getPaymenttandc", error: e);
      return Left(e);
    }
  }
}
