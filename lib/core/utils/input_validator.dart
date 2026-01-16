class InputValidator {
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    
    // Ghana mobile number validation (10 digits starting with 0)
    final regex = RegExp(r'^0[0-9]{9}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid Ghana mobile number';
    }
    
    return null;
  }
  
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    
    return null;
  }
  
  static String? validatePIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    
    return null;
  }
  
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    
    return null;
  }
  
  static String? validateIDNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID number is required';
    }
    
    if (value.length < 5) {
      return 'Please enter a valid ID number';
    }
    
    return null;
  }
  
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    return null;
  }
}
