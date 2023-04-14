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