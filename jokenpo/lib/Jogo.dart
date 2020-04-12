import 'dart:math';

class Jogo{

  var _opcoes = [
    "pedra",
    "papel",
    "tesoura"
  ];

  bool EhVencedor(String suaOpcao, String appOpcao){
    return (GetNextOpcao(appOpcao) == suaOpcao);
  }

  String GetNextOpcao(String opcao){
      var index = _opcoes.indexOf(opcao);
      if(index >= _opcoes.length - 1) return _opcoes[0];
      return _opcoes[index + 1];
  }

  String GetAppOpcao(){
    return _opcoes[Random().nextInt(_opcoes.length)];
  }

  GetOpcoes(){
    return _opcoes;
  }

}