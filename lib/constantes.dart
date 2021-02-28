import 'package:flutter/material.dart';

const kSplashColorDfruto = Color(0xFF43B02A);
const kPrimaryColorDfruto = Color(0xFF4EA630);
const kSecondaryColorDfruto = Color(0xFF7F3E13);
const kUltimateColorDfruto = Color(0xFFFFDF00);
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kTextLigntColor = Color(0xFF7286A5);
const kDefaultPaddin = 20.0;
const kTextLightColor = Color(0xFFACACAC);


const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor ingresa tu correo";
const String kInvalidEmailError = "Por favor ingresa tu correo válido";
const String kPassNullError = "Por favor ingresa tu contraseña";
const String kShortPassError = "La contraseña es muy corta";
const String kMatchPassError = "Las contraseñas no coinciden";
const String kNamelNullError = "Por favor ingrese su nombre";
const String kApellidoNullError = "Por favor ingrese su apellido";
const String kPhoneNumberNullError = "Por favor ingrese su teléfono";
const String kAddressNullError = "Por favor ingrese su dirección";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
