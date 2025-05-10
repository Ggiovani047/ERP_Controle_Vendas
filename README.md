# ERP Vendas

Sistema ERP completo para controle de vendas, estoque, cadastros e geração de relatórios, desenvolvido em Delphi.

---

## 📌 Funcionalidades

- 📦 Cadastro de Produtos e Categorias
- 👥 Cadastro de Clientes e Usuários
- 🛒 Módulo de Vendas com controle de estoque
- 🔐 Controle de Acesso por Permissões
- 📊 Relatórios Gerenciais (clientes, produtos, vendas por data)
- 🗃️ Interface de Administração e Conexão com Banco de Dados
- 📈 Gráficos de desempenho e relatórios impressos
- 🔄 Atualização de estrutura de banco via interface


---

## 🛠️ Tecnologias

- **Delphi (VCL)**
- **ZeosLib** (conexão com bancos como SQL Server ou Firebird)
- **Banco de dados relacional** (utiliza `.dll` de driver DBLib)
- **RLReport** para geração de relatórios e gráficos

---

## 🚀 Como Executar

1. Execute o .EXE `Vendas.exe`.
2. Configure a conexão com o banco de dados no Ini que irá ser gerado no mesmo diretório do .exe.
3. Execute novamente o .EXE `Vendas.exe`.
4. Caso a configuração do banco esteja correta acesse o usuario 'ADMIN', senha: 'mudar@123'.
5. O sistema está pronto para usar.

---

## 📚 Requisitos

- Banco de dados SQL Server Instalado.

---
## 📁 Estrutura do Projeto

```text
📂 ERP_Venda_e_Controle
├── Vendas.dpr                 # Arquivo principal do projeto Delphi
├── uPrincipal.pas             # Interface principal do sistema
├── uPrincipal.dfm             # Formulário principal
├── cadastro/
│   ├── uCadCategoria.pas      # Cadastro de categoria
│   ├── uCadCliente.pas        # Cadastro de cliente
│   ├── uCadProdutoe.pas       # Cadastro de produtos
│   ├── uCadAcaoAcesso.pas     # Cadastro de permissões de usuario
│   └── uCadUsuario.pas        # Cadastro de usuario
├── consultas/
│   ├── uConCategorias.pas     # Consulta rápida de categorias
│   ├── uConClientes.pas       # Consulta rápida de clientes
│   └── uConProdutos.pas       # Consulta rápida de produtos
├── login/
│   ├── cUsuarioLogado.pas     # Classe para guarar informções do usuário logado
│   ├── uAlterarSenha.pas      # Tela para alterar senhas
│   ├── uLogin.pas             # Tela de login de usuário
│   └── uUsuariosVsAcoes.pas   # Tela para admin controlar acessos dos usuarios   
├── processo/
│   ├── uProVenda.pas          # Tela de processo de venda
│   └── cProVenda.pas          # Classe de venda
├── relatorio/
│   ├── uRelCadCliente.pas                   # Relatório básico de clientes
│   ├── uRelCadClienteFicha.pas              # Relatório detalhado (ficha) de cliente
│   ├── uRelCadProduto.pas                   # Relatório básico de produtos
│   ├── uRelCadProdutoComGrupoCategoria.pas  # Produtos com grupo e categoria
│   ├── uRelCategoria.pas                    # Relatório de categorias
│   ├── uRelProVenda.pas                     # Relatório do processo de venda
│   ├── uRelVendaPorData.pas                 # Vendas agrupadas por data
│   └── uSelecionarData.pas                  # Tela para selecionar a data para a geração do relatório de venda por data
├── datamodule/
│   ├── uDTMConexao.pas        # Conexão com banco de dados
│   ├── uDTMVenda.pas          # DataModule de vendas
│   └── uFrmAtualizaDB.pas     # Atualização de banco via interface
├── heranca/
│   └── uTelaHeranca.pas       # Tela de Herança base para as telas de cadastro
└── Classes/
    ├── cEnum.pas                   # Classe para definir tipos personalizados
    ├── cFuncao.pas                 # Classe de funções genéricas uteis
    ├── cFuncaoCriptografia.pas     # Classe para criptografar e descriptografar as senhas do banco
    ├── cCadCategoria.pas           # Classe de categoria
    ├── cCadCliente.pas             # Classe de cliente
    ├── cCadProduto.pas             # Classe de produto
    ├── cCadUsuario.pas             # Classe de usuarios
    ├── cProVenda.pas               # Classe de processo de venda
    ├── cAcaoAcesso.pas             # Classe de controle de permissões
    ├── cArquivoIni.pas             # Classe de criação de ini para conexão com o banco de dados
    ├── cAtualizacaoTabelaMSSQL.pas # Classe de criação das tabelas no banco de dados
    ├── cCep.pas                    # Classe de integração com API VIACEP para cadastro de clientes
    └── cControleEstoque.pas        # Classe de controle de estoque
```


Desenvolvido para fins de estudo, testes e demonstração de um ERP funcional em Delphi.

