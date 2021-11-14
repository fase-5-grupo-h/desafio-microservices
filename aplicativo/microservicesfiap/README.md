# Fase 5 Microsserviços - FIAP

Este aplicativo foi desenvolvido com base na atividade proposta da Fase 5 - Microsserviços da Pós-Graduação de Engenharia de Software da FIAP

# Introdução ao Aplicativo

O aplicativo possui as funções de gerar um Cartão Virtual com base no valor que foi inserido, também permitindo consultar os cartões virtuais já gerados anteriormente.

# Funções e Telas

O aplicativo possui as seguintes telas e funções:

- Tela Inicial: capacidade de visualizar o Cartão Virtual que se encontra ativo, e um menu rápido no formato horizontal
- Histórico de cartões: histórico dos cartões gerados pelo usuário, mostrando o Nº do Cartão, Saldo Restante e a Data original de expiração do cartão.
- Visualizar Cartões: mostra informações do cartão físico e do cartão virtual que está ativo atualmente, dentro desta tela, pode ocorrer duas outras variações de sub-telas. São elas:
	- Gerar Cartão Virtual: exibirá na tela o botão de gerar cartão, que ao pressionar, solicitará um valor de quanto o usuário gostará de colocar de limite neste cartão virtual
	- Registrar Compra: exibirá na tela o botão de registrar compra, que ao pressionar, solicitará um valro de quanto o usuário gostaria de debitar do cartão virtual, sendo que após ocorrido o debito, o cartão é automaticamente desativado

# Como executar

Necessário executar o passo-a-passo do backend, para subir o servidor Docker. Além disso, é necessário que seja executado em um Emulador no computador para que seja possível utilizar a integração.

Link do Back-end: https://github.com/fase-5-grupo-h/desafio-microservices/blob/main/backend

# Troubleshoots

Ao executar, caso ocorra algum erro de HTTP ao Gerar Cartão Virtual ou Registrar compra, execute estes passos:

1 - Vá até a pasta flutter\bin\cache e remova o arquivo chamado ``flutter_tools.stamp``
2 - Vá para a pasta flutter\packages\flutter_tools\lib\src\web e abra o arquivo ``chrome.dart``
3 - Encontre a linha que corresponda a ``--disable-extensions``
4 - Adicione ``--disable-web-security`` logo após a linha do Passo 3.

Com estes passos, você deve conseguir executar normalmente.