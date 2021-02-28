import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/models/proveedor_model.dart';
import 'package:dfruto/src/providers/proveedor_provider.dart';
import 'package:flutter/material.dart';

class FormProveedorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeConfig = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: sizeConfig.height * 0.04), // 4%
                  Text("Regristrar Cliente"),
                  Text(
                    "Completar los siguientes campos",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: sizeConfig.height * 0.08),
                  FormProveedor(),
                  SizedBox(height: sizeConfig.height * 0.05)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormProveedor extends StatefulWidget {
  @override
  _FormProveedorState createState() => _FormProveedorState();
}

class _FormProveedorState extends State<FormProveedor> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  final proveedorProvider = new ProveedorProvider();
  Proveedor proveedor = new Proveedor();

  bool _guardando = false;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Proveedor proveedorArgs = ModalRoute.of(context).settings.arguments;
    if (proveedorArgs != null) {
      proveedor = proveedorArgs;
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: 30),
          buildLastNameFormField(),
          SizedBox(height: 30),
          buildAddressFormField(),
          SizedBox(height: 30),
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPhoneNumberFormField(),
          ElevatedButton(
            onPressed: (_guardando) ? null : _submit,
            child: Text('continuar'),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    if (proveedor.idProveedor == null) {
      proveedorProvider.crearProovedor(proveedor);
    } else {
      proveedorProvider.editarProveedor(proveedor);
    }
    Navigator.pop(context);
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: proveedor.direccion,
      onSaved: (newValue) => proveedor.direccion = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Dirección",
        hintText: "Ingrese su dirección",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: proveedor.telefono,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => proveedor.telefono = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Número telefonico",
        hintText: "Ingrese su teléfono",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: proveedor.apellidos,
      onSaved: (newValue) => proveedor.apellidos = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kApellidoNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kApellidoNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Apellidos",
        hintText: "Ingrese sus apellidos",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: proveedor.nombres,
      onSaved: (newValue) => proveedor.nombres = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nombres",
        hintText: "Ingrese su nombre",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: proveedor.correo,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => proveedor.correo = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Correo",
        hintText: "Ingrese su correo",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
