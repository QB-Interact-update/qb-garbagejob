local Translations = {
    Target = {
        disposeBag = 'Prendi il Sacchetto della Spazzatura',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Butta nel Camion',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Parla con lo Spazzino',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Trucco Rilevato :(',
        droppedWarn = 'Giocatore: %s è stato trovato a più di %s vettori di distanza da dove dovrebbe essere',
        not_employee = 'Il giocatore %s ha provato a iniziare il lavoro della spazzatura ma non è un dipendente',
        already_started = 'Il giocatore %s ha provato a iniziare il lavoro della spazzatura ma lo aveva già avviato; dovrebbe essere impossibile attivarlo due volte',
        notActice = 'Giocatore: %s ha provato a ottenere un percorso ma non era attivo | Questo dovrebbe succedere SOLO se sono coinvolti trigger Lua',
        notEnoughBags = 'Giocatore: %s ha provato ad andare alla fermata successiva ma non aveva raccolto abbastanza sacchetti | Questo dovrebbe succedere SOLO se sono coinvolti trigger Lua',
    },
    Notify = {
        nextStop = "La tua fermata è stata segnata sul GPS",
        doneWorking = "Hai completato il tuo giro! Riporta il camion al deposito.",
        depositPaid = "Hai pagato la cauzione per il camion.",
        truckReturned = "Hai restituito il camion e recuperato la cauzione.",
        too_poor = "Devi pagare %s per iniziare il lavoro",
        foundItem = "Hai trovato un %s mentre raccoglievi i rifiuti!",
    },
    Menu = {
        header = "Menu Principale della Spazzatura",
        collect = 'Ritira lo Stipendio',
        collectText = 'Ritira qui il tuo stipendio guadagnato duramente.',
        startJob = 'Ottieni il Tuo Percorso',
        startJobText = 'Ottieni assegnato un percorso per la raccolta dei rifiuti.',
    }
}

if GetConvar('qb_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
