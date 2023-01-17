import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    //check if user has enabled biometrics.
    //check
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    print(canCheckBiometrics);
    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      print(await _localAuthentication.getAvailableBiometrics());

      try {
        isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}
