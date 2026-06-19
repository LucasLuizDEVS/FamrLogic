def query_fazendas_com_proprietario():
    return """
    SELECT F.Id, F.nome, F.localizacao, F.hectares, P.nome AS nome_proprietario
    FROM Fazenda F
    LEFT JOIN Proprietario P ON F.Id_proprietario = P.Id
    """
