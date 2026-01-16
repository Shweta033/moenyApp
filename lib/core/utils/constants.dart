class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.mobilemoney.gh/api/v1';
  
  // Mobile Money Providers
  static const String mtnMobileMoney = 'MTN';
  static const String vodafoneCash = 'Vodafone';
  static const String airtelTigoMoney = 'AirtelTigo';
  
  // Transaction Limits
  static const double dailyLimitUnverified = 1000.0;
  static const double weeklyLimitUnverified = 5000.0;
  
  // OTP
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 5;
  
  // PIN
  static const int pinLength = 4;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  static const String userPinKey = 'user_pin';
  static const String isLoggedInKey = 'is_logged_in';
}
