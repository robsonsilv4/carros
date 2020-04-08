import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/api_response.dart';
import '../pages/login/usuario.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      final FirebaseUser fUser = result.user;

      // Cria um usuario do app
      final user = Usuario(
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      return ApiResponse.error(message: 'Não foi possível fazer o login');
    }
  }

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fUser = result.user;

      // Cria um usuario do app
      final user = Usuario(
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      return ApiResponse.error(message: 'Não foi possível fazer o login');
    }
  }

  Future<ApiResponse> cadastrar(String nome, String email, String senha) async {
    try {
      // Usuario do Firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      final FirebaseUser fUser = result.user;

      // Dados para atualizar o usuário
      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;
      userUpdateInfo.photoUrl =
          'https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png';

      fUser.updateProfile(userUpdateInfo);

      // Resposta genérica
      return ApiResponse.ok(message: 'Usuário criado com sucesso');
    } catch (error) {
      if (error is PlatformException) {
        return ApiResponse.error(
            message: 'Erro ao criar um usuário.\n\n${error.message}');
      }

      return ApiResponse.error(message: 'Não foi possível criar um usuário.');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
