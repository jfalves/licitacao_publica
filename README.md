########################
INSTRUÇÕES PARA EXECUÇÃO
########################

1. Criar um banco local no Postgres chamado dm_compra como owner o usuÁário 'postgres';
2. Rodar o script sql na pasta 'bando de dados';
3. alterar todas as conexões de banco no pentaho com a senha do usuário 'postgres' da sua máquina (stage, dimensão e fato);
4. Executar os jobs de Scraping, Stage, Dimensão e Fato, nessa ordem.

#1	Introdução

Este documento tem por finalidade coletar, analisar e definir as principais necessidades do projeto do estudo de caso Auditoria de Licitações Públicas. O documento procura demonstrar os principais problemas atuais e o foco investigativo desejado pelo cliente.



#2	Estudo de Caso

##2.1	Descrição do Estudo de Caso

Desde de a Lei de Acesso à Informação – LAI, criada em 2012, os dados de administração pública devem ser abertos para a população, o que foi realizado através dos portais de transparência. Entre os motivos para tal, além da obrigação legal, estão a transparência pública, viabilização de novas negócios e a contribuição da sociedade com serviços inovadores ao cidadão.

Este trabalho pretende sumarizar fatos do setor de compras governamentais, mais especificamente licitações públicas, a fim de facilitar o acesso a população, afinal, como afirma a lei de Linus, idealizada pelo hacker Eric S. Raymond:

“Dados olhos suficientes, todos os erros são óbvios”

O presente trabalho engloba a licitação e contratação tanto de serviços quanto materiais, incluindo dados de fornecedores. Não está contemplado no escopo dados de pregões e compras emergenciais feitas, portanto, sem uma licitação.

Para tal foram utilizados os dados disponíveis no portal http://compras.dados.gov.br/ que por sua vez foram extraídos do Sistema Integrado de Administração e Serviços Gerais - SIASG. Esses dados foram sumarizados em um Datawarehouse através da ferramenta de integração Hitachi Pentaho e armazenados no banco de dados Postgres. Ademais, toda a visualização de dados foi feita através do Microsoft Power BI.



#3	Descrição do Modelo Transacional
Os dados estão estruturados em arquivos textos, portanto não há um modelo relacional explícito, mesmo assim, segue o modelo de dados.


##3.1	Fonte 1 – Licitações - http://compras.dados.gov.br/licitacoes/v1/licitacoes.csv

Fornece dados sobre licitações cadastradas, no formato csv (Comma-separated Values)

Campo	Descrição
data_abertura_proposta	Data de abertura da proposta.
data_entrega_edital	Data de Entrega do Edital.
data_entrega_proposta	Data de entrega da proposta.
data_publicacao	Data da publicação da licitação.
endereco_entrega_edital	Endereço de Entrega do Edital.
funcao_responsavel	Função do Responsável pela Licitação.
Identificador	Identificador da Licitação.
informacoes_gerais	Informações Gerais.
Modalidade	Código da Modalidade da Licitação.
nome_responsavel	Nome do Responsável pela Licitação.
numero_aviso	Número do Aviso da Licitação.
numero_itens	Número de Itens.
numero_processo	Número do Processo.
Objeto	Objeto da Licitação.
situacao_aviso	Situação do aviso.
tipo_pregao	Tipo do Pregão.
tipo_recurso	Tipo do Recurso.
Uasg	Código da UASG.

##3.2	Fonte 2 – Item Licitação - http://compras.dados.gov.br/licitacoes/id/licitacao/{id_licitacao}/itens.csv

Fornece uma lista das informações relacionadas aos registros do Item de licitação, no formato csv (Comma-separated Values)

Campo	Descrição
beneficio	Benefício.
cnpj_fornecedor	CNPJ Vencedor.
codigo_item_material	Código do Material.
codigo_item_servico	Código do Serviço.
cpfVencedor	CPF Vencedor.
criterio_julgamento	Critério de Julgamento.
decreto_7174	Decreto 7174.
descricao_item	Descrição do item.
modalidade	Modalidade da licitação.
numero_aviso	Número do aviso.
numero_item_licitacao	Número do item de licitação.
numero_licitacao	Identificador da licitação associada.
quantidade	Quantidade de itens de licitação
sustentavel	Se o item é sustentável
uasg	UASG.
unidade	Unidade.
valor_estimado	Valor Estimado.


##3.3	Fonte 3 – Contratos - http://compras.dados.gov.br/contratos/v1/contratos.csv

Fornece dados sobre contratos realizados, no formato csv (Comma-separated Values)

Campo	Descrição
cnpj_contratada	CNPJ da empresa contratada.
codigo_contrato	Tipo de Contrato.
cpfContratada	CPF da contratada.
data_assinatura	Data de assinatura do contrato.
data_inicio_vigencia	Data de início de vigência dos contratos.
data_termino_vigencia	Data de término de vigência dos contratos.
fundamento_legal	Fundamento legal do processo de contratação.
Identificador	Identificador do Contrato
licitacao_associada	Referência à licitação que originou a contratação.
modalidade_licitacao	Número e o ano da licitação que originou a contratação.
Numero	Campo seguido pelo número do contrato, seguido do respectivo ano.
numero_aditivo	Quantidade de termos aditivos de um contrato.
numero_aviso_licitacao	Número do aviso da licitação que originou a contratação.
numero_processo	Número do processo de contratação.
Objeto	Descrição do objeto, a partir de uma descrição de item/serviço informada.
origem_licitacao	Origem da licitação que gerou o contrato: Preço praticado(SISPP) ou Registro de preço(SISRP).
Uasg	Campo de seis digitos que indica o código da UASG contratante.
valor_inicial	Valor inicial do contrato.

##3.4	Fonte 4 – Fornecedores - http://compras.dados.gov.br/fornecedores/v1/fornecedores.csv

Fornece dados sobre fornecedores, no formato csv (Comma-separated Values)


Campo	Descrição
Ativo	Se o fornecedor está ativo.
caixa_postal	Caixa Postal do Fornecedor.
Cpf	CPF do fornecedor.
Cnpj	CNPJ do fornecedor
habilitado_licitar	Campo que indica se o fornecedor está habilitado a licitar.
Id	Identificador único do fornecedor no SICAF.
Municipio	Identificador único de município no SICAF.
Unidade_cadastradora	Identificador único da UASG.
Nome	Nome do fornecedor.
Recadastrado	Se o fornecedor se recadastrou no Novo SICAF.
Uf	Sigla da UF.
Natureza Jurídica	Natureza jurídica do fornecedor.
Porte da Empresa	Fornece dados sobre o porte do fornecedor.

Ramo do Negócio	Fornece uma descrição detalhada relacionada a um ramo de negócio informado.

##3.5	Fonte 5 – Materiais - http://compras.dados.gov.br/materiais/v1/materiais.csv

Fornece dados sobre materiais contratados, no formato csv (Comma-separated Values)

Campo	Descrição
Código	Código do item de material.
Descrição	Descrição do material.
id_classe	Código da classe de material.
id_grupo	Código do grupo de material
id_pdm	Código do padrão descritivo de material.
Status	Indicador se o item é ou não ativo.
Sustentável	Indicador se o item é ou não sustentável.

##3.6	Fonte 6 – Serviços - http://compras.dados.gov.br/servicos/v1/servicos.html

Fornece dados sobre materiais contratados, no formato csv (Comma-separated Values)

Campo	Descrição
Código	Código do serviço.
codigo_classe	Código da classe.
codigo_divisao	Código da divisão.
codigo_grupo	Código do grupo.
codigo_secao	Código da seção.
codigo_subclasse	Código da subclasse.
Cpc	Código da Classificação Central de Produto.
Descrição	Descrição do serviço.
unidade_medida	Unidade de medida do serviço.


#4	Proposta de Processo de BI  

O processo de BI envolve um web-scraping da API de compras disponibilizada pelo governo, que ocorrerá mensalmente. Esse processo baixará os arquivos csv com os dados descritos na seção anterior.

Após termos esses dados fisicamente, serão extraídos sem transformação para tabelas de Staging e com isso, lidos do banco e compilados no datamart estruturado no modelo estrela, para facilitar a consulta do aplicativo de visualização de dados.

#5	Modelo Multidimensional

Esta seção apresenta o modelo estrela (star schema) do estudo de caso Auditoria de Licitações Públicas.


#6	Elaboração do Data Warehouse

O Data Warehouse será a fonte integradora de informações da empresa, a tecnologia será utilizada com o intuito de servir de base para a camada de aplicação que será responsável por fornecer dados para a tomada de decisão na organização.

##6.1	Definição do DW

###6.1.1	Arquitetura

A arquitetura escolhida para a abordagem do problema foi um Data Mart isolado, ou seja, independente, uma vez que queremos responder uma pergunta muito específica dos dados de compra pública, a saber, quais foram as compras feitas através de licitações.

###6.1.2	Abordagem de Construção

Como dito anteriormente, por se tratar de uma pergunta bem simples sobre os dados de compras públicas, o modelo botton-up pareceu mais adequado, podendo no futuro ser integrado em um modelo mais complexo de dados.

###6.1.3	Arquitetura Física

Como os dados de compras são públicos, não houve preferência na escolha da arquitetura física, tendo sido implementado um banco local por simplicidade.

#7	Projeto de ETL

##7.1	Descrição do Projeto de ETL
O projeto de ETL compreende 4 etapas que foram organizadas da seguinte forma na ferramenta PDI (Pentaho Data Integrator):
Primeiro, é feito um scraping da api de compras do governo gerando arquivos físicos no formato csv. Esses arquivos contêm no máximo 500 linhas, pois é o limite fornecido pela API. Após esse processo o conteúdo dos arquivos é carregado sem transformações para as tabelas de stage, que devem ter seu formato e estrutura igual dos arquivos.
Com isso é feito toda a parte da transformação dos dados lendo das stages e carregando nas respectivas dimensões. Uma vez carregado todas as dimensões, é feita a carga da tabela fato, que relaciona todas as dimensões previamente carregadas.
Na pasta ”banco de dados” do projeto temos a estrutura a ser criada bem como um dump do banco de dados.

#8	Dashboard

##8.1	Descrição da Elaboração
Para a camada de visualização foi utilizado o software Power BI por sua simplicidade e conteúdo disponível na internet.

##8.2	Telas do Dashboard
Foi desenvolvido uma tela que compila todos os dados coletados como quantidade de contratos, licitações, fornecedores e itens; Top 10 fornecedores e unidades administrativas por seus respectivos gastos, etc.
Como filtro é possível selecionar se é uma material ou serviço prestado, qual unidade administrativa fez a compra, qual o estado brasileiro entre outros.

#Conclusão
Com essa visão inicial dos dados de compras federais o grupo espera que pessoas se interessem e comecem a consultar gastos das unidade administrativas ou do estado em que vivem para que possam ser os olhos da auditoria e possam cobrar melhores práticas com o dinheiro que a princípio também é nosso.

#9	Arquivos

##9.1	Pasta Banco de Dados
Contém a estrutura do banco de dados no formato sql e o dump do banco no formato tar.

##9.2	Pasta Dados
Contém os arquivos csv baixados da api de compras do governo.

##9.3	Pasta Documentação
Contém esse arquivo bem como o modelo do data mart.

##9.4	Pasta Pentaho
Contém as transformações e Jobs que fizeram a carga do projeto.
