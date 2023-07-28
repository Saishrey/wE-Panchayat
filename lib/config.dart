class Config {
  static const String appName = "wE-Panchayat";
  static const String apiURL = "10.0.2.2:3001";  // emulator
  // static const String apiURL = "192.168.1.5:3001";  // from phone
  // static const String apiURL = "e894-14-139-113-18.ngrok-free.app";

  static const String loginAPI = "/auth/login";
  static const String signupAPI = "/auth/signup";
  static const String otpAPI = "/auth/get-otp";
  static const String logoutAPI = "/auth/logout";
  static const String resetPassAPI = "/auth/reset-password";
  static const String verifyOtpAPI = "/auth/verify-otp";
  static const String resendOtpAPI = "/auth/resend-otp";
  static const String checkSessionAPI = "/user/check-session";
  static const String blockUserAPI = "/auth/block-user";

}

class TradeLicenseAPI {
  static const String saveFormAPI = "/trade-license/save-form";
  static const String deleteFormAPI = "/trade-license/delete-form";
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
  static const String deleteFormAPI = "/income-certificate/delete-form";
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


class HouseTaxAPI {
  static const String houseTaxAPI = "/house-tax/get-house-tax";
}

class BirthCertificateAPI {
  static const String birthCertificateAPI = "/birth-certificate/search";
}

class DeathCertificateAPI {
  static const String deathCertificateAPI = "/death-certificate/search";
}

class GrievanceAPI {
  static const String submitGrievanceAPI = "/grievance/submit";
  static const String uploadGrievanceImagesAPI = "/grievance/upload";
  static const String retrieveGrievanceAPI = "/grievance/retrieve";
  static const String retrieveAllGrievanceAPI = "/grievance/retrieve-all";
}


class ProfilePicAPI {
  static const String uploadPictureAPI = "/user/upload-profile-pic";
  static const String updatePictureAPI = "/user/update-profile-pic";
  static const String retrievePictureAPI = "/user/retrieve-profile-pic";
  static const String deletePictureAPI = "/user/delete-profile-pic";
}

class UpdateEmailAPI {
  static const String getOtpAPI = "/user/get-otp";
  static const String verifyOtpAPI = "/auth/verify-otp";
  static const String updateEmailAPI = "/user/update-email";
}