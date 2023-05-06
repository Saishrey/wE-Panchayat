class Config {
  static const String appName = "wE-Panchayat";
  static const String apiURL = "10.0.2.2:3001";  // emulator
  // static const String apiURL = "192.168.1.4:3001";  // from phone
  static const String loginAPI = "/auth/login";
  static const String signupAPI = "/auth/signup";
  static const String otpAPI = "/auth/get-otp";
  static const String logoutAPI = "/auth/logout";
  static const String resetPassAPI = "/auth/reset-password";
  static const String verifyOtpAPI = "/auth/verify-otp";
  static const String resendOtpAPI = "/auth/resend-otp";
}

class TradeLicenseAPI {
  static const String saveFormAPI = "/trade-license/save-form";
  static const String retrieveFormAPI = "/trade-license/retrieve-form";
  static const String updateFormAPI = "/trade-license/update-form";
  static const String uploadDocumentsAPI = "/trade-license/upload-documents";
  static const String updateDocumentsAPI = "/trade-license/update-documents";
  static const String retrieveDocumentsAPI = "/trade-license/retrieve-documents";
  static const String generateLicensePDFAPI = "/trade-license/generate-license";
  static const String retrieveLicensePDFAPI = "/trade-license/retrieve-license";
}


class IncomeCertificateAPI {
  static const String saveFormAPI = "/income-certificate/save-form";
  static const String retrieveFormAPI = "/income-certificate/retrieve-form";
  static const String updateFormAPI = "/income-certificate/update-form";
  static const String uploadDocumentsAPI = "/income-certificate/upload-documents";
  static const String updateDocumentsAPI = "/income-certificate/update-documents";
  static const String retrieveDocumentsAPI = "/income-certificate/retrieve-documents";
  static const String generateCertificatePDFAPI = "/income-certificate/generate-certificate";
  static const String retrieveCertificatePDFAPI = "/income-certificate/retrieve-certificate";
}

class ApplicationsAPI {
  static const String allApplicationsAPI = "/user/all-applications";
}