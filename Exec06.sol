// SPDX-License-Identifier: GPL-3.0

/**
   Crie um contrato capaz de controlar a matrícula de alunos (identificados por
seu nome e idade) à determinada disciplina (para facilitar, podemos considerar
o contrato como sendo a própria disciplina). O aluno só pode se matricular uma
única vez à disciplina.
Apenas alunos com idade igual a 18 anos podem se matricular na
disciplina. O nome do aluno é um parâmetro obrigatório, e podemos ter alunos
com o mesmo nome.
Na prática, cada aluno é um endereço de origem, então um endereço A
pode se matricular uma única vez, por exemplo.
O contrato deve possuir funções para a inclusão deste aluno, para
consulta (verificar se determinado aluno está matriculado), para verificar quantos
alunos estão matriculados no total e posso querer remover um aluno da lista de
matrícula – porém, apenas o endereço que fez a matrícula é o endereço que
pode fazer a remoção.
    */

    pragma solidity >=0.8.12 <0.9.0;

    contract Exercicio06 {

        struct Student{
            bool Registered;
            uint Age;
            string Name;
        }

        uint mapSize;

        mapping(address => Student) students;

        function RegisterStudent(string memory _name, uint _age) public {
            require(students[msg.sender].Registered != true, "Student always registered!");
            require(_age == 18, "Only students with age equal 18! can register!");

            Student storage newStudent = students[msg.sender];
            newStudent.Registered = true;
            newStudent.Name = _name;
            newStudent.Age = _age;
            students[msg.sender] = newStudent;

            mapSize++;
            
        }

        function studentIsRegistered(address _address) public view returns (bool){
            Student storage newStudent = students[_address];
            return newStudent.Registered;
        }

        function countStudentRegistered() public view returns (uint cont){
            return mapSize;
        }

        function removeStudenty()public {
            delete students[msg.sender];
            mapSize--;
        }
    }