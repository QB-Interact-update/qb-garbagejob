local Translations = {
    Target = {
        disposeBag = 'Pegar Saco de Lixo',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Jogar no Caminhão',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Falar com o Lixeiro',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Trapaça Detectada :(',
        droppedWarn = 'Jogador: %s foi encontrado a mais de %s vetores de distância de onde deveria estar',
        not_employee = 'Jogador %s tentou iniciar o trabalho de lixeiro, mas não é um funcionário',
        already_started = 'Jogador %s tentou iniciar o trabalho de lixeiro, mas já havia começado; isso deveria ser impossível de ativar duas vezes',
        notActice = 'Jogador: %s tentou obter uma rota, mas não estava ativo | Isso só deveria acontecer se triggers de Lua estiverem envolvidos',
        notEnoughBags = 'Jogador: %s tentou ir para a próxima parada, mas não coletou sacos suficientes | Isso só deveria acontecer se triggers de Lua estiverem envolvidos',
    },
    Notify = {
        nextStop = "Sua parada foi marcada no seu GPS",
        doneWorking = "Você terminou sua rota! Devolva o caminhão ao depósito.",
        depositPaid = "Você pagou seu depósito pelo caminhão.",
        truckReturned = "Você devolveu o caminhão e recebeu seu depósito de volta.",
        too_poor = "Você precisa pagar %s para começar o trabalho",
        foundItem = "Você encontrou um %s enquanto coletava lixo!",
    },
    Menu = {
        header = "Menu Principal do Lixo",
        collect = 'Receber Salário',
        collectText = 'Receba aqui seu suado salário.',
        startJob = 'Pegar Sua Rota',
        startJobText = 'Receba uma rota de coleta de lixo atribuída.',
    }
}

if GetConvar('qb_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
