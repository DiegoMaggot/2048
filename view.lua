cores = {
    branco = {0.78, 0.97, 0.97},
    turquesa = {0, 0.80, 0.81, 0.6},
    cyan = {0, 0.54, 0.54},
}
--cores dos blocos.
blocos = {
    {0, 1, 1},
    {0, 206/255, 209/255},
    {64/255, 224/255, 208/255},
    {72/255, 209/255, 204/255},
    {32/255, 178/255, 170/255},
    {0, 139/255, 139/255},
    {0, 128/255, 128/255},
    {127/255, 1, 212/255},
    {102/255, 205/255, 170/255},
    {95/255, 158/255, 160/255},
    {0, 1, 127/255}
}

local background = display.newRect(display.contentCenterX, display.contentCenterY, 800, 800)
background.fill = cores.cyan

tableGroup = display.newGroup()
tableGroup.x, tableGroup.y = 31, 40

tableRect = display.newRoundedRect(tableGroup, 129, 196, 265, 265, 5)
tableRect.fill = cores.turquesa

function pontuacaoView(group, x, y, text, value)
    rect = display.newRoundedRect(group, x, y, 80, 45, 5)
    rect.fill = cores.turquesa
    campo = display.newRoundedRect(group, x, y, 75, 40, 5)
    campo.fill = cores.branco
    campo.valor = display.newText(value, x + group.x, y + group.y, native.systemFont, 18)
    campo.valor:setFillColor(0, 0.54, 0.54)
    placarText = display.newText(text, x + group.x, group.y - 72, native.systemFont, 16)
end
pontuacaoView(tableGroup, 135, -40, "pontuação", "0")
pontuacaoView(tableGroup, 225, -40, "record", "0")

--game-over
gameOverText = nil
--venceu
youWinText = nil
--botões de direçoes habiliar/desabilitar 
move = false

--novo-jogo
function newGame( event )
    if (gameOverText ~= nil) then
        gameOverText:removeSelf()
        gameOverText = nil
    elseif (youWinText ~= nil) then
        youWinText:removeSelf()
        youWinText = nil
    end
    newGame(4)
    move = true
    mostrar(tabela)
end
--game
newX, newY = 60, 2
newButton = display.newRoundedRect(newX, newY, 60, 40, 5)
newButton.fill = cores.branco
newButton.valor = display.newText("New", newX, newY, native.systemFont, 18)
newButton.valor:setFillColor(0, 0.54, 0.54)
newButton:addEventListener("tap", newGame)

local function moveEvent( event )
    if(move) then
        moverPara(event.target.valor)
        mostrar(tabela)
        if(gameOver()) then
            gameOverText = display.newText("Game Over", 165, 80, native.systemFont, 30)
            move = false
        elseif (vitoria()) then
            youWinText = display.newText("Você Venceu", 165, 80, native.systemFont, 30)
            move = false
        end
    end
end
--factory de botões
function newButton(group, x, y, width, height, color, icon, direction)
    local button = nil
        button = display.newRoundedRect(group, x, y, width, height,5)
        button.fill = color
        if(direction ~= nil and icon ~= nil ) then
            button:addEventListener("tap", moveEvent)
            button.image = display.newImage("icons/"..icon..".png", x + buttonsGroup.x, y + buttonsGroup.y);
            button.image:scale(0.8, 0.8)
            button.valor = direction
        end
    return button
end

buttonsGroup = display.newGroup()
buttonsGroup.x, buttonsGroup.y = 75, 325
buttonRect = newButton(buttonsGroup, 85, 119, 160, 150, cores.cyan) --retângulo que engloba os botões.
btnEsquerda = newButton(buttonsGroup, 35, 120, 50, 50, cores.cyan, "arrow_left", "←")
btnCima = newButton(buttonsGroup, 85, 75, 50, 50, cores.cyan, "arrow_up", "↑")
btnBaixo = newButton(buttonsGroup, 85, 165, 50, 50, cores.cyan, "arrow_down", "↓")
btnDireita = newButton(buttonsGroup, 135, 120, 50, 50, cores.cyan, "arrow_right", "→")

--factory de retângulos
function newRect(group, x, y, width, height, color)
    local rect = nil
        rect = display.newRoundedRect(group, x, y, width, height,5)
        rect.fill = color
        rect.valor = display.newText("", x + tableGroup.x, y + tableGroup.y, native.systemFont, 18)
        rect.valor:setFillColor(0, 0.54, 0.54)
    return rect
end

--gera a imagem do tabuleiro.
function tableView()
    posX, posY, pecaSize = 33, 100, 60
    for i = 1, 4 do
        value = 0
        for j = 1, 4 do
            rect = newRect(tableGroup, posX * (j + value) - value * 2, posY, pecaSize, pecaSize, cores.branco)
            value = j
        end
        posY = posY + pecaSize + 4
    end
end
tableView()

function mostrar(tabela)
    local k = 6
    for i = 1, #tabela do
        for j = 1, #tabela do
            if (tabela[i][j] == 0) then
                tableGroup[k].valor.text = ""
                tableGroup[k].fill = cores.branco
                tableGroup[k].valor:setFillColor(0, 0.54, 0.54)
            else
                tableGroup[k].valor.text = tabela[i][j]
                value = tonumber(tableGroup[k].valor.text)
                tableGroup[k].fill = blocos[getBlocoCor(value)]
                tableGroup[k].valor:setFillColor(1, 1, 1)
            end
            tableGroup[3].valor.text = pontuacao
            tableGroup[5].valor.text = record
            k = k + 1
        end
    end
end

function getBlocoCor(num)
    for j = 1, 11 do
        num = num / 2
        if(num == 1) then
            return j
        end
    end
end