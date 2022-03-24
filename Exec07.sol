// SPDX-License-Identifier: GPL-3.0

/**
    Você está trabalhando em um contrato que será utilizado por uma operadora
de telefonia celular, como parte do seu programa de fidelidade. Segundo o
regulamento, um usuário (identificado por seu endereço) possui pontos, e estes
pontos podem ser trocados por produtos. Quando um usuário se inscreve para
participar do programa, ele automaticamente ganha 2 pontos como boas-vindas.
A troca de pontos por produtos segue a lógica:
• Um relógio pode ser trocado por 10 pontos
• Um celular pode ser trocado por 50 pontos
• Um computador pode ser trocado por 100 pontos
O contrato deve ter funções capazes de fazer o cadastro do usuário, consulta
dos pontos disponíveis, inclusão de pontos para o usuário (recebidos por
parâmetro) e de realização de troca de pontos por produtos.
Deve ser possível verificar todos os produtos que um usuário já trocou em
algum momento. Deve ser possível também verificar se um usuário já possui ou
não determinado produto.
Por último, quero poder consultar, na lista de produtos, os usuários que
escolheram determinado produto para trocar trocado (por exemplo, se João troca
pontos por um Computador, e Pedro troca pontos por outro Computador, quando 
eu consultar o produto “Computador”, quero saber que ele foi trocado por João
e por Pedro).
Faça todas as implementações necessárias.
    */

    pragma solidity >=0.8.12 <0.9.0;

    contract Exercicio07 {

        struct User{
            bool Registered;
            string[] Product;
            uint Points;
        }

        struct Product{
            uint valuePoints;
            string Type;
        }

        struct ProductExchaged{
           string Type;
           address[] _address;
        }

        string[] ProductType = ["Register", "Clock", "CellPhone", "Computer"];
        
        mapping(address => User) Users;

        mapping(string => Product) Products;
        mapping(string => ProductExchaged) ProductExchageds;

        constructor(){
            for(uint i = 0;i < ProductType.length;i++){
                createProduct(ProductType[i]);    
            }
        }

        function RegisterUser(address _address) public {
            require(Users[_address].Registered != true, "User always registered!");
            
            User storage newUser = Users[_address];
            newUser.Registered = true;
            newUser.Points = policyPoints(ProductType[0]);

            newUser.Product = [ProductType[0]];

            Users[_address] = newUser;
        }

        function getPointsAvaiable(address _address) public view returns (uint){
            require(Users[_address].Registered != false, "User not registered!");
            User storage newUser = Users[_address];
            return newUser.Points;
        }

        function includePoint(address _address, uint _points) public{
            require(Users[_address].Registered != false, "User not registered!");

            User storage newUser = Users[_address];
            newUser.Points = newUser.Points + _points;
        }

        function exchangeOfPoints(address _address, uint _points, string memory _type ) public{
            require(Users[_address].Registered != false, "User not registered!");

            ProductExchaged storage exchanged = ProductExchageds[_type];
            Product storage newProduct = Products[_type];
            User storage newUser = Users[_address];

            newUser.Product.push(_type);
            newUser.Points = newUser.Points - _points;

            require(_points >= newProduct.valuePoints, "No has points avaiables to exchage with product!");
            
            exchanged._address.push(address(_address));
            exchanged.Type = _type;

            ProductExchageds[_type] = exchanged;
        }

        function policyPoints(string  memory _product)private view returns (uint points){
            if(compareString(_product, ProductType[0])){
                return 2;
            }else if(compareString(_product, ProductType[1])){
                return 10;
            }else if(compareString(_product, ProductType[2])){
                return 50;
            }else if(compareString(_product, ProductType[3])){
                return 100;
            }else{
                return 0;
            }
        }

        function createProduct(string memory _type)private {

            Product memory newProduct;
            newProduct.valuePoints = policyPoints(_type);
            newProduct.Type = _type;

            Products[_type] = newProduct;
        }

        function compareString(string memory a, string memory b)private pure returns (bool){
            return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
        }

        function userHasProduct(address _address, string memory _type)public view returns (bool){
            require(Users[_address].Registered != false, "User not registered!");

            User storage newUser = Users[_address];
            for(uint i = 0; i < newUser.Product.length; i++){
                if(compareString(newUser.Product[i], _type))
                {
                    return true;
                }
            }
            return false;
        }

        function getAllProductWasExchangedByUser(address _address)public view returns (string[] memory){
            require(Users[_address].Registered != false, "User not registered!");

            User storage newUser = Users[_address];
            
            return newUser.Product;
        }

        function getAllProductWasExchangedByProduct(string memory _type)public view returns (ProductExchaged memory){

            ProductExchaged storage products = ProductExchageds[_type];
            
            return products;
        }

        function getAllProductAvaiable()public view returns (string[] memory){
            
            return ProductType;
        }
    }