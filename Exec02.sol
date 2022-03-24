// SPDX-License-Identifier: GPL-3.0

/**
   Você está trabalhando em um contrato que se propõe a realizar operações
matemáticas simples. Este contrato possui um contador de interações que, por
decisão de negócio, deve ser inicializado com o valor de 50.
Este contrato deve possuir uma funcionalidade capaz de consultar o valor
da variável de estado, e outra função que é invocada para incrementar o valor
do contador em 1 – independentemente do endereço de origem da invocação, o
incremento deve refletir para todos os usuários.
Faça as implementações necessárias
    */

    pragma solidity >=0.8.12 <0.9.0;

    contract Exercicio02 {

        uint8 cont = 50;

        function getValueCont() public view returns(uint8){

            return cont;
        }

        function increaseValueCont() public{

            cont = cont + 1;
        }
        
    }