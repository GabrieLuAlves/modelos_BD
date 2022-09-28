use mydb; # [IMPORTANTE] Executar antes de executar qualquer consulta

/* Selecionar todos os atributos da tabela de credores */
SELECT * FROM empresas;

/* Selecionar o código e o nome de todos os credores em ordem alfabética */
SELECT empresas.id_empresa, empresas.nome FROM empresas ORDER BY empresas.nome ASC;

/* 
	Mostrar todas as compras (credor, numero, data e valor) realizadas
    ordanado por credor e data da compra 
*/
SELECT
	empresas.nome, compras.id_compra, compras.data_compra, compras.valor_total
FROM
	empresas, compras
WHERE
	empresas.id_empresa = compras.id_empresa
ORDER BY empresas.nome, compras.data_compra;

/*
	Mostrar todas as compras (numero, data e valor) de um credor específico
    cadastrado no banco de dados 
*/
/* inserir id da empresa em WHERE empresas.id_empresa = (id)*/
SELECT
	empresas.nome, compras.unidades, compras.data_compra, compras.valor_total
FROM
	empresas, compras
WHERE
	empresas.id_empresa = compras.id_empresa AND
    empresas.id_empresa = 1 /* id informado */;

/* Listar todas as compras que tiveram um valor acima de R$ 5.000,00 */
SELECT compras.id_compra, compras.descricao FROM compras WHERE compras.valor_total > 5000;
/*
	Listar todas as parcelas (credor, descrição da compra, sequência da parcela,
    valor da parcela, data do vencimento) que estão em aberto, ou seja, ainda
    não foram pagas por ordem de data do vencimento (uma parcela não paga é
    uma parcela que tem a data de pagamento ou o valor pago em branco)
*/
SELECT
	empresas.nome, compras.descricao, parcelas.sequencia,
    parcelas.valor_parcela, parcelas.vencimento
FROM
	empresas, compras, parcelas
WHERE
	empresas.id_empresa = compras.id_empresa AND
    compras.id_compra = parcelas.id_compra AND
    parcelas.data_pagamento = NULL
ORDER BY parcelas.vencimento ASC;

/*
	Listar todos os dados de uma determinada compra (numero da compra,
    data, descrição, credor, dados das parcelas) incluindo todas as parcelas
*/
SELECT
	compras.id_compra, compras.data_compra, compras.descricao, empresas.nome as nome_empresa,
    parcelas.*
FROM
	compras, empresas, parcelas
WHERE
	compras.id_compra = 1 /* id informado */ AND
    compras.id_compra = empresas.id_empresa AND
    compras.id_compra = parcelas.id_compra;

/*
	Listar todos os pagamentos efetuados (data do pagamento, valor pago,
    multa, juros, credor, numero da compra) por ordem de data do pagamento e credor
*/
SELECT
	compras.id_compra, parcelas.data_pagamento, parcelas.valor_parcela,
    pagamentos.multa, pagamentos.juros, empresas.nome as nome_empresa
FROM
	empresas, compras, parcelas, pagamentos
WHERE
	parcelas.data_pagamento != NULL AND
	compras.id_empresa = empresas.id_empresa AND
    compras.id_compra = parcelas.id_compra AND
    parcelas.id_parcela = pagamentos.id_parcela;
    
/*
	Listar todas as contas (parcelas) que devem ser pagas em uma data de vencimento específica
*/
SELECT
	compras.descricao, parcelas.valor_parcela, parcelas.vencimento
FROM
	compras, parcelas
WHERE
	parcelas.id_compra = compras.id_compra AND
    parcelas.vencimento = "2022-09-15" /* data informada */;

/*
	Mostrar sem repetição todas as compras (credor, numero e data da compra)
    que possuem pelo menos uma parcela em atraso. Uma parcela em atraso é
    aquela cuja data é anterior a data atual e cujo valor ou data do pagamento
    se encontram em branco;
*/
SELECT DISTINCT
	DISTINCT compras.id_compra, empresas.nome as nome_empresa, compras.data_compra
FROM
	compras, empresas, parcelas
WHERE
	compras.id_empresa = empresas.id_empresa AND
    compras.id_compra = parcelas.id_parcela AND
    parcelas.vencimento < now() AND
    parcelas.data_pagamento = NULL;
    
/*
	Listar todas as parcelas que foram pagas com atraso (credor, data vencimento,
    data pagamento, valor multa, valor juros, total pago). As parcelas pagas com
    atraso foram as que a data do pagamento registrada é posterior a data de
    vencimento (datpag > datven);
*/
SELECT
	empresas.nome as nome_empresa, parcelas.vencimento, parcelas.data_pagamento,
    pagamentos.multa, pagamentos.juros,
    parcelas.valor_parcela + pagamentos.juros + pagamentos.multa as total_pago
FROM
	empresas, compras, parcelas, pagamentos
WHERE
    parcelas.data_pagamento != NULL AND
	parcelas.data_pagamento < parcelas.vencimento AND
	empresas.id_empresa = compras.id_empresa AND
    compras.id_compra = parcelas.id_compra AND
    parcelas.id_parcela = pagamentos.id_parcela;