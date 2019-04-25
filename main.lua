esp = require 'posix'
--cria o tabuleiro 4x4
tabela = {}
--sempre vai criar uma matriz quadrada linhas == colunas
function criarTabela(tamanho)
    for i = 1, tamanho do
        tabela[i] = {}   
        for j = 1, tamanho do
            tabela[i][j] = 0
        end
    end
end
--zerar tabela
function zerarTabela()
    for i = 1, getTamanho(tabela) do  
        for j = 1, getTamanho(tabela) do
            tabela[i][j] = 0
        end
    end
end

--mostra o tabuleiro
function mostrar(tabela)
    for i = 1, getTamanho(tabela) do
        for j = 1, getTamanho(tabela) do
            if (tabela[i][j] == 0) then
                io.write ("[ ]")
            else
                io.write ("["..tabela[i][j].."]")
            end
        end
            io.write ("\n")
    end
end

--pega a quantidade de linhas da tabela
function getTamanho(tabela)
    return table.maxn(tabela)
end

--ver se alguma posição da tabela está livre
function posicaoLivre()
    for i = 1, getTamanho(tabela) do
        for j = 1, getTamanho(tabela) do
            if(tabela[i][j] == 0) then
                return true
            end
        end
    end
    return false
end

--checar posição checa se a posição recebida está livre (4)
function checarPosicao(i, j)
    if(i >= 1 and i <= getTamanho(tabela) and j >= 1 and j <= getTamanho(tabela)) then 
        if(tabela[i][j] ~= 0) then
            return false
        else
            return true
        end
    end
end

--gerar o valor da nova peça um número entre 2(70%) e 4(30%)
function novaPeca()
    math.randomseed(os.time())
    esp.sleep(1)
    num = math.random(10);
    if(num <= 7) then
        return 2
    else 
        return 4
    end
end

--gera um valor aleatório para linha/coluna da nova peca
function getPosicao()
    math.randomseed(os.time())
    esp.sleep(1)
    return math.random(getTamanho(tabela))
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
    for k = 1, getTamanho(tabela) do
        for i = 1, getTamanho(tabela) do
            for j = 1, getTamanho(tabela) do
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
    if(tabela[i][j] == tabela[i][j + 1]) then
        return true
    else
        return false
    end
end

--soma os elementos da esquerda se forem iguais
function somarEsquerda()
    for i = 1, getTamanho(tabela) do
        for j = 1, getTamanho(tabela) do
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
    for k = 1, getTamanho(tabela) do
        for i = 1, getTamanho(tabela) do
            for j = 1, (getTamanho(tabela) - 1) do
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
    if(tabela[i][j] == tabela[i][j - 1]) then
        return true
    else
        return false
    end
end

--soma os elementos da direita se forem iguais
function somarDireita()
    for i = 1, getTamanho(tabela) do
        for j = getTamanho(tabela), 2, -1 do
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
    for k = 1, getTamanho(tabela) do
        for i = getTamanho(tabela), 2, -1 do
            for j = 1, getTamanho(tabela) do
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
    if(tabela[i][j] == tabela[i + 1][j]) then
        return true
    else
        return false
    end
end

--soma os elementos de baixo se forem iguais
function somarAcima()
    for i = 1, (getTamanho(tabela) - 1) do
        for j = 1, getTamanho(tabela) do
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
    for k = 1, getTamanho(tabela) do
        for i = 1, (getTamanho(tabela) - 1) do
            for j = 1, getTamanho(tabela) do
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
    if(tabela[i][j] == tabela[i - 1][j]) then
        return true
    else
        return false
    end
end

--soma os elementos de baixo se forem iguais
function somarAbaixo()
    for i = getTamanho(tabela), 2, -1 do
        for j = 1, getTamanho(tabela) do
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

--Move as peças do tabuleiro para uma direção escolhida. adicionando uma nova peça caso o tabuleiro sofra mudança.
function moverPara(direcao)
    tabelaCopia = clone(tabela)
    if(direcao == "d") then
        direita()
    elseif (direcao == "a") then
        esquerda()
    elseif (direcao == "w") then
        cima()
    elseif (direcao == "s") then
        baixo()
    end
    if(not(compareTable(tabela, tabelaCopia))) then
        addPeca()
        return true
    end
    return false
end

--compara duas tabelas
function compareTable(tabela1, tabela2)
    for i = 1, getTamanho(tabela1) do
        for j = 1, getTamanho(tabela2) do
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
    for i = 1, getTamanho(tabela) do
            Tclone[i] = {}
        for j = 1, getTamanho(tabela) do
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
    for i = 1, (getTamanho(tabela) - 1) do
        for j = 1, getTamanho(tabela) do
            if(compareElementosAcima(i, j)) then
                return false
            end
        end
    end
    --linhas
    for i = 1, getTamanho(tabela) do
        for j = getTamanho(tabela), 2, -1 do
            if(compareElementosDireita(i, j)) then
                return false
            end
        end
    end
    return true
end

function vitoria()
    for i = 1, getTamanho(tabela) do
        for j = 1, getTamanho(tabela) do
            if(tabela[i][j] == 2048) then
                return true
            end
        end
    end
    return false
end

function newGame(tamanho)
    criarTabela(tamanho)
    addPeca()
    addPeca()
end

function game(tamanho)
    record = 0
    pontuacao = 0
    local direcao
    newGame(tamanho)

    continuar = true
    while continuar do

    print("\nRecord atual: "..record.."\npontuação: "..pontuacao)
    mostrar(tabela)
    io.write("\nw (cima) - a(esquerda) - s(baixo) - d(direita): ")
    direcao = io.read()

    if(direcao == "w" or direcao == "s" or direcao =="d" or direcao == "a") then
        moverPara(direcao)
    end
    if(pontuacao > record) then
        record = pontuacao
    end

    if(gameOver()) then
        print("\nGame Over")
        print("Record atual: "..record.."\npontuação: "..pontuacao)
        mostrar(tabela)
        continuar = false
    end
        if(vitoria()) then
        print("\nCongratulations you win")
        print("Record atual: "..record.."\npontuação: "..pontuacao)
        mostrar(tabela)
        continuar = false
    end

    if(continuar == false) then
        io.write("\nnovo jogo ? (s / n) ")
            if(io.read() == "s") then
            continuar = true
            newGame(tamanho)
            pontuacao = 0
            end
        end
    end
end

game(4)
