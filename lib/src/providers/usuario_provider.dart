import 'dart:convert';

import 'package:formu_val/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firabaseToken = 'AIzaSyAcAjSIOmj-jsowg_VXQuw1JoaDqRpm6Dw';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firabaseToken';
    final resp = await http.post(Uri.parse(url), body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firabaseToken';
    final resp = await http.post(Uri.parse(url), body: json.encode(authData));
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }



  }


  
}
