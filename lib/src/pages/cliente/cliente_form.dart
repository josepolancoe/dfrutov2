import 'package:dfruto/constantes.dart';
import 'package:dfruto/src/models/cliente_model.dart';
import 'package:dfruto/src/providers/cliente_provider.dart';
import 'package:flutter/material.dart';

class FormClientePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final sizeConfig = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Cliente'),),
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
                  AdminFormClientes(),
                  SizedBox(height: sizeConfig.height * 0.05)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // _formClientes() {}
}

class AdminFormClientes extends StatefulWidget {
  @override
  _AdminFormClientesState createState() => _AdminFormClientesState();
}

class _AdminFormClientesState extends State<AdminFormClientes> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  final clienteProvider = new ClienteProvider();
  Cliente cliente = new Cliente();
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
    Cliente clienteArgs = ModalRoute.of(context).settings.arguments;
    if (clienteArgs != null) {
      cliente = clienteArgs;
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
          ElevatedButton(onPressed: (_guardando) ? null : _submit, child: Text('continuar'), ),

          
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
    if (cliente.idCliente == null) {
      clienteProvider.crearCliente(cliente);
    } else {
      clienteProvider.editarCliente(cliente);
    }
    Navigator.pop(context);
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: cliente.direccion,
      onSaved: (newValue) => cliente.direccion = newValue,
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
      initialValue: cliente.telefono,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => cliente.telefono = newValue,
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
      initialValue: cliente.apellidos,
      onSaved: (newValue) => cliente.apellidos = newValue,
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
      initialValue: cliente.nombres,
      onSaved: (newValue) => cliente.nombres = newValue,
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
      initialValue: cliente.correo,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => cliente.correo = newValue,
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
