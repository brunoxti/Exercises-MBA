// SPDX-License-Identifier: GPL-3.0

/**
    Você está trabalhando em um contrato que realiza o acompanhamento da
    vida dos usuários. Ele possui uma função que realiza a classificação do ser
    humano, conforme sua idade (recebida por parâmetro), em três fases da sua
    vida: criança (se tiver menos do que 18 anos), adulto (se tiver 18 anos ou mais)
    e idoso (se tiver 60 anos ou mais).
    Implemente as funções necessárias para criar uma base de dados
    contendo os usuários (identificados pelo seu nome), sua idade e classificação, e
    para realizar a consulta, quando um nome for enviado como um parâmetro. Por
    simplificação, assumimos que nenhum nome de usuário se repetirá.
    */

pragma solidity >=0.8.12 <0.9.0;

contract Exercicio01 {

struct User
{
    string faseLife;
    uint8 age;
    string name;
}

mapping(uint256 => User) users;
uint8[] public usersId;

    function setClassification (uint8 _age, string memory _name, uint8 id) public{
        User storage newUser = users[id];

        if(_age < 18 ) {
            newUser.faseLife = "crianca";
        }
        else if(_age >= 18 && _age < 60){ 
            newUser.faseLife = "adulto";
        }
        else if (_age >= 60){
            newUser.faseLife = "idoso";
        }

        newUser.name = _name;
        newUser.age = _age;

        usersId.push(id);
    }

    function getUser(uint8 id) public view returns (string memory, uint){
        User storage user = users[id];
        return (string(abi.encodePacked("Nome: ",user.name, " Fase: ",user.faseLife)), user.age);
        
    }
}



