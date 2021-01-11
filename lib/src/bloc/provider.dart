import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
import 'package:form_validation/src/bloc/productos_bloc.dart';
export 'package:form_validation/src/bloc/login_bloc.dart';
export 'package:form_validation/src/bloc/productos_bloc.dart';

// Forma en que recomienda flutter que se maneje los datos
class Provider extends InheritedWidget {
  static Provider _instancia;
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();

  // Pregunta si ya esta inicializado si no lo crea
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }
}
