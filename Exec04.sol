// SPDX-License-Identifier: GPL-3.0

/**
   4 – Seu contrato é especializado em manipular arrays. Ele deve ser capaz de
receber como parâmetro um array de números inteiros (tamanho variável), sem
repetição, em tempo de compilação, e deve possuir funcionalidades para
remoção de determinado valor.
Por exemplo, em um array inicial [1,2,3], se eu invocar a funcionalidade
de remoção passando o número 2 como parâmetro, o array inicial deve virar
[1,3].
Da mesma maneira, quero ter uma funcionalidade que inclua um valor ao
final do array, para que ele cresça. Contudo, nenhum valor repetido é aceitável;
caso isto ocorra, não devo ser capaz de incluir o número.
Faça as implementações necessárias.
    */

    pragma solidity >=0.8.12 <0.9.0;

     contract Exercicio04 {

        uint[] array = [1,2,3,4,5,6];

        function removeNumber(uint _number) public {
             for(uint i = 0; i < array.length; i++){
                 if(array[i] == _number){
                     delete array[i];

                     for(uint j = i; j <= array.length;j++){
                         if(array[j] == array[array.length-1]){
                             break;
                         }
                         array[j] = array[j+1];
                     }
                     array.pop();
                 }
             }
        }

        function addNumber(uint _number) public {
            require(validateNumberAtArray(_number), "Nao permitido numero repetido");
            array.push(_number);
        }

        function addNewArray(uint[] memory _array) public {
            require(validateArray(_array), "Nao permitido numero repetido");
                array = _array;
        }

        function validateArray(uint[] memory _array) internal pure returns(bool result){

            for (uint j = 0; j < _array.length; j++){
                uint value = _array[j];

                for(uint i = j+1; i < _array.length; i++){
                    if(value == _array[i])
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        function validateNumberAtArray(uint _number) internal view returns(bool result){

            for (uint j = 0; j < array.length; j++){
                if(_number == array[j]){
                    return false;
                }
            }
            return true;
        }

        function getArray() public view returns(uint[] memory result){

            return array;    
        }
    }