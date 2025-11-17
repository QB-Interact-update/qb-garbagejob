local Translations = {
    Target = {
        disposeBag = 'Apanhar Saco do Lixo',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Atirar para o Camião',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Falar com o Lixeiro',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Batota Detetada :(',
        droppedWarn = 'Jogador: %s foi encontrado a mais de %s vetores de distância do local onde deveria estar',
        not_employee = 'O jogador %s tentou iniciar o trabalho de lixo, mas não é um funcionário',
        already_started = 'O jogador %s tentou iniciar o trabalho de lixo, mas já o tinha iniciado; deveria ser impossível ativar isto duas vezes',
        notActice = 'Jogador: %s tentou obter uma rota, mas não estava ativo | Isto só deveria acontecer se estiverem envolvidos triggers de Lua',
        notEnoughBags = 'Jogador: %s tentou ir para a próxima paragem, mas não recolheu sacos suficientes | Isto só deveria acontecer se estiverem envolvidos triggers de Lua',
    },
    Notify = {
        nextStop = "A tua paragem foi marcada no teu GPS",
        doneWorking = "Terminaste a tua rota! Devolve o camião ao depósito.",
        depositPaid = "Pagaste o teu depósito pelo camião.",
        truckReturned = "Devolveste o camião e recebeste o teu depósito de volta.",
        too_poor = "Precisas de pagar %s para começar o trabalho",
        foundItem = "Encontraste um %s enquanto recolhias lixo!",
    },
    Menu = {
        header = "Menu Principal do Lixo",
        collect = 'Receber Salário',
        collectText = 'Recebe aqui o teu salário arduamente ganho.',
        startJob = 'Obter a Tua Rota',
        startJobText = 'Recebe uma rota de recolha de lixo atribuída.',
    }
}

if GetConvar('qb_locale', 'en') == 'pt' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
