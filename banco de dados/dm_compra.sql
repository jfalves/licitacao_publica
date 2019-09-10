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
                Modalidade_da_Licita��o VARCHAR,
                N�mero_do_Aviso_da_Licita��o VARCHAR,
                C�digo_do_Contrato VARCHAR,
                Licita��o_associada VARCHAR,
                Origem_da_Licita��o VARCHAR,
                N�mero VARCHAR,
                Objeto VARCHAR,
                N�mero_de_Aditivos VARCHAR,
                N�mero_do_Processo VARCHAR,
                CPF_Contratada VARCHAR,
                CNPJ_Contratada VARCHAR,
                Data_de_Assinatura VARCHAR,
                Fundamento_Legal VARCHAR,
                Data_de_In�cio_da_Vig�ncia VARCHAR,
                Data_de_Termino_da_Vig�ncia VARCHAR,
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
                Munic�pio VARCHAR,
                UF VARCHAR,
                Natureza_Jur�dica VARCHAR,
                Porte_da_Empresa VARCHAR,
                Ramo_do_Neg�cio VARCHAR,
                Unidade_Cadastradora VARCHAR,
                CNAE VARCHAR,
                CNAE_Secund�rio VARCHAR,
                Habilitado_a_Licitar VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_licitacao(
                UASG VARCHAR,
                Modalidade_da_Licita��o VARCHAR,
                N�mero_do_Aviso_da_Licita��o VARCHAR,
                Identificador_da_Licita��o VARCHAR,
                Tipo_do_Preg�o VARCHAR,
                Situa��o_do_Aviso VARCHAR,
                Objeto VARCHAR,
                Informa��es_Gerais VARCHAR,
                N�mero_do_Processo VARCHAR,
                Tipo_de_Recurso VARCHAR,
                N�mero_de_Itens_na_Licita��o VARCHAR,
                Nome_do_Respons�vel VARCHAR,
                Fun��o_do_Respons�vel VARCHAR,
                Data_de_Entrega_do_Edital VARCHAR,
                Endere�o_de_Entrega_do_Edital VARCHAR,
                Data_de_Abertura_da_Proposta VARCHAR,
                Data_de_Entrega_da_Proposta VARCHAR,
                Data_de_Publica��o VARCHAR,
                Itens_da_licita��o_uri VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_item(
                UASG VARCHAR,
                Modalidade_da_Licita��o VARCHAR,
                N�mero_do_Aviso_da_Licita��o VARCHAR,
                N�mero_da_Licita��o VARCHAR,
                N�mero_do_Item_na_Licita��o VARCHAR,
                C�digo_do_Servi�o VARCHAR,
                C�digo_do_Material VARCHAR,
                Descri��o_do_Item VARCHAR,
                Item_sustent�vel VARCHAR,
                Quantidade VARCHAR,
                Unidade_de_medida VARCHAR,
                CNPJ_do_Vencedor VARCHAR,
                CPF_do_Vencedor VARCHAR,
                Benef�cio VARCHAR,
                Valor_estimado VARCHAR,
                Decreto_7174 VARCHAR,
                Crit�rio_de_Julgamento VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_material (
                C�digo_do_Item VARCHAR,
                Descri��o_do_Item VARCHAR,
                Grupo VARCHAR,
                Classe VARCHAR,
                PDM VARCHAR,
                Status VARCHAR,
                Sustent�vel VARCHAR
)

CREATE TABLE IF NOT EXISTS stage_servico (
                C�digo VARCHAR,
                Descri��o VARCHAR,
                Unidade_medida VARCHAR,
                CPC VARCHAR,
                Se��o VARCHAR,
                Divis�o VARCHAR,
                Grupo VARCHAR,
                Classe VARCHAR,
                Subclasse VARCHAR
)