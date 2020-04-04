import 'package:carros/pages/carro/carro.dart';

class CarroApi {
  static List<Carro> getCarros() {
    final carros = List<Carro>();

    carros.add(
      Carro(
        nome: 'Lamborghini Aventador',
        urlFoto:
            'http://www.livroandroid.com.br/livro/carros/esportivos/Lamborghini_Aventador.png',
      ),
    );
    carros.add(
      Carro(
        nome: 'Chevrolet Corvette Z06',
        urlFoto:
            'http://www.livroandroid.com.br/livro/carros/esportivos/Chevrolet_Corvette_Z06.png',
      ),
    );
    carros.add(
      Carro(
        nome: 'BMW M5',
        urlFoto:
            'http://www.livroandroid.com.br/livro/carros/esportivos/BMW.png',
      ),
    );

    return carros;
  }
}
