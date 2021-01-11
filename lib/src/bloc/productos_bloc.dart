import 'dart:io';

import 'package:form_validation/src/models/producto_model.dart';
import 'package:form_validation/src/providers/producto_provider.dart';
import 'package:rxdart/subjects.dart';

class ProductosBloc {
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final productosProvider = new ProductosProvider();
  Stream<List<ProductoModel>> get productosStream =>
      _productosController.stream;

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProductos() async {
    final productos = await productosProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    await productosProvider.borrarProductos(id);
  }

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }
}
