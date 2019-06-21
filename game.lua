math.randomseed(os.time())
--cria o tabuleiro 4x4
tabela = {}
record, pontuacao = 0, 0
--sempre vai criar uma matriz quadrada linhas == colunas
function criarTabela(tamanho)
    for i = 1, tamanho do
        tabela[i] = {}   
        for j = 1, tamanho do
            tabela[i][j] = 0
        end
    end
end
--vê se alguma posição da tabela está livre
function posicaoLivre()
    for i = 1, #tabela do
        for j = 1, #tabela do
            if(tabela[i][j] == 0) then
                return true
            end
        end
    end
    return false
end
--checa se a posição recebida está livre
function checarPosicao(i, j)
    if(i >= 1 and i <= #tabela and j >= 1 and j <= #tabela) then 
        if(tabela[i][j] ~= 0) then
            return false
        else
            return true
        end
    end
end
--gerar o valor da nova peça um número entre 2(70%) e 4(30%)
function novaPeca()
    num = math.random(10);
    return num <= 7 and 2 or 4 
end
--gera um valor aleatório para linha/coluna da nova peca
function getPosicao()
    return math.random(#tabela)
end
--adiciona uma nova peca em uma posição aleatória.
function addPeca()
    continuar = false
    repeat
        linha = getPosicao()
        coluna = getPosicao()
        continuar = not(posicaoLivre())
        if(checarPosicao(linha, coluna)) then
                tabela[linha][coluna] = novaPeca()
                continuar = true
        end
    until continuar
end
--Move todas as peças para esquerda
function moverParaEsquerda()
    for k = 1, #tabela do
        for i = 1, #tabela do
            for j = 1, #tabela do
                if(j ~= 1) then
                    if(tabela[i][j - 1] == 0) then
                        tabela[i][j - 1] = tabela[i][j]
                        tabela[i][j] = 0
                    end
                end
            end
        end
    end
end
--compara os elementos da linha
function compareElementosEsquerda(i, j)
    return tabela[i][j] == tabela[i][j + 1] and true or false
end
--soma os elementos da esquerda se forem iguais
function somarEsquerda()
    for i = 1, #tabela do
        for j = 1, #tabela do
            if(compareElementosEsquerda(i, j)) then
                tabela[i][j] = tabela[i][j] + tabela[i][j + 1]
                tabela[i][j + 1] = 0
                pontuacao = pontuacao + tabela[i][j]
            end
        end
    end
end
--Move todas as peças para direita
function moverParaDireita()
    for k = 1, #tabela do
        for i = 1, #tabela do
            for j = 1, (#tabela - 1) do
                if(tabela[i][j + 1] == 0) then
                    tabela[i][j + 1] = tabela[i][j]
                    tabela[i][j] = 0
                end
            end
        end
    end
end
--compara os elementos da linha
function compareElementosDireita(i, j)
    return tabela[i][j] == tabela[i][j - 1] and true or false
end
--soma os elementos da direita se forem iguais
function somarDireita()
    for i = 1, #tabela do
        for j = #tabela, 2, -1 do
            if(compareElementosDireita(i, j)) then
                tabela[i][j] = tabela[i][j] + tabela[i][j - 1]
                tabela[i][j - 1] = 0
                pontuacao = pontuacao + tabela[i][j]
            end
        end
    end
end
--Move todas as peças para cima
function moverParaCima()
    for k = 1, #tabela do
        for i = #tabela, 2, -1 do
            for j = 1, #tabela do
                if(tabela[i - 1][j] == 0) then
                    tabela[i - 1][j] = tabela[i][j]
                    tabela[i][j] = 0
                end
            end
        end
    end
end
--compara os elementos da linha acima
function compareElementosAcima(i, j)
    return tabela[i][j] == tabela[i + 1][j] and true or false
end
--soma os elementos de baixo se forem iguais
function somarAcima()
    for i = 1, (#tabela - 1) do
        for j = 1, #tabela do
            if(compareElementosAcima(i, j)) then
                tabela[i][j] = tabela[i][j] + tabela[i + 1][j]
                tabela[i + 1][j] = 0
                pontuacao = pontuacao + tabela[i][j]
            end
        end
    end
end
--Move todas as peças para baixo
function moverParaBaixo()
    for k = 1, #tabela do
        for i = 1, (#tabela - 1) do
            for j = 1, #tabela do
                if(tabela[i + 1][j] == 0) then
                    tabela[i + 1][j] = tabela[i][j]
                    tabela[i][j] = 0
                end
            end
        end
    end
end
--compara os elementos da linha abaixo
function compareElementosAbaixo(i, j)
    return tabela[i][j] == tabela[i - 1][j] and true or false
end
--soma os elementos de baixo se forem iguais
function somarAbaixo()
    for i = #tabela, 2, -1 do
        for j = 1, #tabela do
            if(compareElementosAbaixo(i, j)) then
                tabela[i][j] = tabela[i][j] + tabela[i - 1][j]
                tabela[i - 1][j] = 0
                pontuacao = pontuacao + tabela[i][j]
            end
        end
    end
end
--executa a lógica da movimentação para direita
function direita()
    moverParaDireita()
    somarDireita()
    moverParaDireita()

end
--executa a lógica da movimentação para esquerda
function esquerda()
    moverParaEsquerda()
    somarEsquerda()
    moverParaEsquerda()
end
--executa a lógica da movimentação para cima
function cima()
    moverParaCima()
    somarAcima()
    moverParaCima()
end
--executa a lógica da movimentação para baixo
function baixo()
    moverParaBaixo()
    somarAbaixo()
    moverParaBaixo()
end
--Move as peças do tabuleiro para uma direção escolhida, adicionando uma nova peça caso o tabuleiro sofra mudança.
function moverPara(direcao)
    tabelaCopia = clone(tabela)
    if(direcao == "→") then
        direita()
    elseif (direcao == "←") then
        esquerda()
    elseif (direcao == "↑") then
        cima()
    elseif (direcao == "↓") then
        baixo()
    end
    if(pontuacao > record) then
        record = pontuacao
    end
    if(not(compareTable(tabela, tabelaCopia))) then
        addPeca()
        return true
    end
    return false
end
--compara duas tabelas
function compareTable(tabela1, tabela2)
    for i = 1, #tabela1 do
        for j = 1, #tabela2 do
            if(tabela1[i][j] ~= tabela2[i][j]) then
                return false
            end
        end
    end
    return true
end
--clona a tabela 
function clone(tabela)
    Tclone = {}
    for i = 1, #tabela do
        Tclone[i] = {}
        for j = 1, #tabela do
            Tclone[i][j] = tabela[i][j]
        end
    end
    return Tclone
end
--fim de jogo
function gameOver()
    if(posicaoLivre()) then
        return false
    end
    --colunas
    for i = 1, (#tabela - 1) do
        for j = 1, #tabela do
            if(compareElementosAcima(i, j)) then
                return false
            end
        end
    end
    --linhas
    for i = 1, #tabela do
        for j = #tabela, 2, -1 do
            if(compareElementosDireita(i, j)) then
                return false
            end
        end
    end
    return true
end

function vitoria()
    for i = 1, #tabela do
        for j = 1, #tabela do
            if(tabela[i][j] == 2048) then
                return true
            end
        end
    end
    return false
end

function newGame(tamanho)
    criarTabela(tamanho)
    pontuacao = 0
    addPeca()
    addPeca()
end