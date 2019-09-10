CREATE TABLE IF NOT EXISTS dimensao_item (
                sk_item SERIAL NOT NULL,
                nk_item VARCHAR NOT NULL,
                grupo VARCHAR NOT NULL,
                classe VARCHAR NOT NULL,
                descricao VARCHAR NOT NULL,
                status VARCHAR NOT NULL,
                servico BOOLEAN NOT NULL,
                material BOOLEAN NOT NULL,
                CONSTRAINT dimensao_item_pk PRIMARY KEY (sk_item)
);


CREATE TABLE IF NOT EXISTS dimensao_contrato (
                sk_contrato SERIAL NOT NULL,
	        nk_contrato VARCHAR NOT NULL,
                inicio_vigencia TIMESTAMP NOT NULL,
                fim_vigencia TIMESTAMP NOT NULL,
                tipo VARCHAR NOT NULL,
                CONSTRAINT dimensao_contrato_pk PRIMARY KEY (sk_contrato)
);


CREATE TABLE IF NOT EXISTS dimensao_licitacao (
                sk_licitacao SERIAL NOT NULL,
                nk_licitacao VARCHAR NOT NULL,
                modalidade VARCHAR NOT NULL,
                unidade_administrativa VARCHAR NOT NULL,
                responsavel VARCHAR,
                cargo_responsavel VARCHAR,
                CONSTRAINT dimensao_licitacao_pk PRIMARY KEY (sk_licitacao)
);


CREATE TABLE IF NOT EXISTS dimensao_fornecedor (
                sk_fornecedor SERIAL NOT NULL,
                nk_fornecedor VARCHAR NOT NULL,
                municipio VARCHAR NOT NULL,
                uf CHAR(2) NOT NULL,
                pf BOOLEAN NOT NULL,
                pj BOOLEAN NOT NULL,
                habilitado BOOLEAN NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT dimensao_fornecedor_pk PRIMARY KEY (sk_fornecedor)
);


CREATE TABLE IF NOT EXISTS fato_compra (
                sk_contrato INTEGER NOT NULL,
                sk_licitacao INTEGER NOT NULL,
                sk_item INTEGER NOT NULL,
                sk_fornecedor INTEGER NOT NULL,
                valor_inicial NUMERIC NOT NULL,
                numero_aditivo INTEGER NOT NULL,
                quantidade_itens INTEGER NOT NULL,
                CONSTRAINT fato_compra_pk PRIMARY KEY (sk_contrato)
);


ALTER TABLE fato_compra ADD CONSTRAINT dimensao_objeto_fato_compra_fk
FOREIGN KEY (sk_item)
REFERENCES dimensao_item (sk_item)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dimensao_contrato_fato_compra_fk
FOREIGN KEY (sk_contrato)
REFERENCES dimensao_contrato (sk_contrato)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dimensao_licitacao_fato_compra_fk
FOREIGN KEY (sk_licitacao)
REFERENCES dimensao_licitacao (sk_licitacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fato_compra ADD CONSTRAINT dimensao_fornecedor_fato_compra_fk
FOREIGN KEY (sk_fornecedor)
REFERENCES dimensao_fornecedor (sk_fornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

CREATE TABLE IF NOT EXISTS stage_contrato (
		Identificador_do_Contrato VARCHAR,
                UASG VARCHAR,
                Modalidade_da_Licitação VARCHAR,
                Número_do_Aviso_da_Licitação VARCHAR,
                Código_do_Contrato VARCHAR,
                Licitação_associada VARCHAR,
                Origem_da_Licitação VARCHAR,
                Número VARCHAR,
                Objeto VARCHAR,
                Número_de_Aditivos VARCHAR,
                Número_do_Processo VARCHAR,
                CPF_Contratada VARCHAR,
                CNPJ_Contratada VARCHAR,
                Data_de_Assinatura VARCHAR,
                Fundamento_Legal VARCHAR,
                Data_de_Início_da_Vigência VARCHAR,
                Data_de_Termino_da_Vigência VARCHAR,
                Valor_inicial VARCHAR,
                Aditivos_do_Contrato_uri VARCHAR,
                Apostilamentos_do_Contrato_uri VARCHAR,
                Eventos_do_Contrato_uri VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_fornecedor (
                Id VARCHAR,
                CNPJ VARCHAR,
                CPF VARCHAR,
                Nome VARCHAR,
                Ativo VARCHAR,
                Recadastrado VARCHAR,
                Município VARCHAR,
                UF VARCHAR,
                Natureza_Jurídica VARCHAR,
                Porte_da_Empresa VARCHAR,
                Ramo_do_Negócio VARCHAR,
                Unidade_Cadastradora VARCHAR,
                CNAE VARCHAR,
                CNAE_Secundário VARCHAR,
                Habilitado_a_Licitar VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_licitacao(
                UASG VARCHAR,
                Modalidade_da_Licitação VARCHAR,
                Número_do_Aviso_da_Licitação VARCHAR,
                Identificador_da_Licitação VARCHAR,
                Tipo_do_Pregão VARCHAR,
                Situação_do_Aviso VARCHAR,
                Objeto VARCHAR,
                Informações_Gerais VARCHAR,
                Número_do_Processo VARCHAR,
                Tipo_de_Recurso VARCHAR,
                Número_de_Itens_na_Licitação VARCHAR,
                Nome_do_Responsável VARCHAR,
                Função_do_Responsável VARCHAR,
                Data_de_Entrega_do_Edital VARCHAR,
                Endereço_de_Entrega_do_Edital VARCHAR,
                Data_de_Abertura_da_Proposta VARCHAR,
                Data_de_Entrega_da_Proposta VARCHAR,
                Data_de_Publicação VARCHAR,
                Itens_da_licitação_uri VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_item(
                UASG VARCHAR,
                Modalidade_da_Licitação VARCHAR,
                Número_do_Aviso_da_Licitação VARCHAR,
                Número_da_Licitação VARCHAR,
                Número_do_Item_na_Licitação VARCHAR,
                Código_do_Serviço VARCHAR,
                Código_do_Material VARCHAR,
                Descrição_do_Item VARCHAR,
                Item_sustentável VARCHAR,
                Quantidade VARCHAR,
                Unidade_de_medida VARCHAR,
                CNPJ_do_Vencedor VARCHAR,
                CPF_do_Vencedor VARCHAR,
                Benefício VARCHAR,
                Valor_estimado VARCHAR,
                Decreto_7174 VARCHAR,
                Critério_de_Julgamento VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_material (
                Código_do_Item VARCHAR,
                Descrição_do_Item VARCHAR,
                Grupo VARCHAR,
                Classe VARCHAR,
                PDM VARCHAR,
                Status VARCHAR,
                Sustentável VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_servico (
                Código VARCHAR,
                Descrição VARCHAR,
                Unidade_medida VARCHAR,
                CPC VARCHAR,
                Seção VARCHAR,
                Divisão VARCHAR,
                Grupo VARCHAR,
                Classe VARCHAR,
                Subclasse VARCHAR
)