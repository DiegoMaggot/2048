para testar as mensagens de game over e você venceu 
é só fazer as seguintes alterações em criarTabela em game.lua

--game over:

function criarTabela(tamanho)
    for i = 1, tamanho do
        tabela[i] = {}   
        for j = 1, tamanho do
            tabela[i][j] = i + j
        end
    end
    tabela[2][1] = 2
end

--e seguir com uma sequência de movimetos para baixo.

--você venceu:

function criarTabela(tamanho)
    for i = 1, tamanho do
        tabela[i] = {}   
        for j = 1, tamanho do
            tabela[i][j] = 1024
        end
    end
end

--e mover para qualquer direção.