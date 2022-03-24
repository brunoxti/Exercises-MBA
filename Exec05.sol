// SPDX-License-Identifier: GPL-3.0

/**
   4 – Você está trabalhando em um contrato que cadastra pessoas (identificadas
pelos seus endereços) aos serviços oferecidos pela sua solução. Em um dado
momento, os status do contrato podem ser: Em análise, Liberado, Cancelado e
Rejeitado.
Crie as funções necessárias para implementar funcionalidades que
relacionem endereços com os status possíveis, e para fazer suas consultas
(posso querer saber qual o status do endereço A, por exemplo).
Contratos Rejeitados não podem ter seu status alterado em qualquer
hipótese.
Contratos Liberados podem ser Cancelados, porém, não podem voltar
para o status Em Análise.
Contratos Cancelados, por sua vez, só podem passar para o status Em
Análise.
Um contrato pode ser Rejeitado em qualquer ponto.
Por segurança, só posso modificar o status de um endereço após pelo
menos 30 segundos da última alteração..
    */

    pragma solidity >=0.8.12 <0.9.0;

     contract Exercicio05 {

         uint constant TIME_WAIT = 30 seconds;

        struct User{
            Status Status;
            bool Registered;
            uint LastUpdated;
        }

        enum Status{
            InAnalysis,
            Released,
            Canceled,
            Rejected,
            Undefined
        }   
        mapping(address => User) users;


        function RegisterUser() public {
            require(users[msg.sender].Registered == true, "User always registered!");

            User storage newUser = users[msg.sender];
            newUser.Registered = true;
            users[msg.sender] = newUser;

            setUserToInAnalysis(msg.sender);

            users[msg.sender] = newUser;
        }

        function getUserByAddress(address _address) public view returns(address ,  string memory) {
            User memory _user = users[_address];
            
            return (_address, castEnum(_user.Status));
        }

        function setUserToReject(address _address) public {
            StatusWasUpdatedMoreThan30Seconds(users[_address].LastUpdated);
            
            setUserStatus(_address, Status.Rejected);
        }

        function setUserToReleased(address _address) public {
            StatusWasUpdatedMoreThan30Seconds(users[_address].LastUpdated);
            require(users[_address].Status == Status.InAnalysis, "Only contracts in Analysis can be Approved");

            setUserStatus(_address, Status.Released);
        }

        function setUserToCancel(address _address) public {
            StatusWasUpdatedMoreThan30Seconds(users[_address].LastUpdated);

            setUserStatus(_address, Status.Canceled);
        }

        function setUserToInAnalysis(address _address) public {
            UserIsCreated(_address);
            StatusWasUpdatedMoreThan30Seconds(users[_address].LastUpdated);
            require(users[_address].Status == Status.Canceled, "Only Canceled contracts can be set back to Analysis");

            setUserStatus(_address, Status.InAnalysis);
        }

        function castEnum(Status _status)private pure returns (string memory){
            if(_status == Status.InAnalysis){
                return "Em analise";
            }
            if(_status == Status.Released){
                return "Liberado";
            }
            if(_status == Status.Canceled){
                return "Cancelado";
            }
            if(_status == Status.Rejected){
                return "Rejeitado";
            }
            return "Undefined";
        }

        function StatusWasUpdatedMoreThan30Seconds(uint _lastUpdated) private view {
            require(_lastUpdated + TIME_WAIT < block.timestamp, "You have to wait 30 seconds before updating user!");
        }

        function UserIsCreated(address _address) private view {
            require(users[_address].Registered == false, "User was not created!");
        }

        function setUserStatus(address _address, Status _status)private {
            require(_status != Status.Rejected, "Rejected customer cannot be updated!");

            User storage _user = users[_address];
            _user.Status = _status;
            _user.LastUpdated = block.timestamp;

            users[_address] = _user;
        }
    }