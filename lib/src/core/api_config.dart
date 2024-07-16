class ApiConfig {
  static const liveBaseUrl = 'https://www.pesuacademy.com';
  static const testBaseUrl = 'https://rr.pesuacademy.com';
  static const loginApi = '/MAcademy/mobile/mobilelogin';
  static const googleloginApi = '/MAcademy/googleLoginCheck/';
  static const dispatecher = '/MAcademy/mobile/dispatcher';
  static const testPdf = 'https://rr.pesuacademy.com/MAcademy/previewAnnouncementFile/';
  static const livePdf = 'https://www.pesuacademy.com/MAcademy/previewAnnouncementFile/';
  static const testAttendance='https://rr.pesuacademy.com/MAcademy/mobile/dispatcher';
  static const liveAttendance='https://www.pesuacademy.com/MAcademy/mobile/dispatcher';
  static late String openPdf;
  static late String openAttendancePdf;
  static void setOpenPdf({required String newOpenPdfValue}) {
    openPdf = newOpenPdfValue;
  }
}
