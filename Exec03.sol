// SPDX-License-Identifier: GPL-3.0

/**
   Modifique o contrato anterior para que ele armazene os endereços de origem
de invocação da função de adição. Ele deve ser capaz de mostrar quem foi (o 
endereço) e quantas vezes a pessoa invocou a funcionalidade de incremento.
Deve possuir também uma funcionalidade de consulta por um endereço (por
exemplo, quero descobrir quantas vezes o endereço A já invocou a execução).
    */

    pragma solidity >=0.8.12 <0.9.0;

    contract Exercicio03 {

        struct User
        {
            address _address;
            uint8 countCall;
        }

        mapping(address => User) users;
        address[] private usersId;

        uint8 cont = 0;

        constructor(){
            cont = 50;
        }

        function getValueCont() public view returns(uint8){

            return cont;
        }

        function increaseValueCont() public{

            User storage newUser = users[msg.sender];
            newUser.countCall = newUser.countCall + 1;
            usersId.push(msg.sender);

            cont = cont + 1;
        }

        function getTransactionByUser(address _user) public view returns(address theAddress, uint){

            User storage user = users[_user];
            return (_user, user.countCall);
        }
        
    }