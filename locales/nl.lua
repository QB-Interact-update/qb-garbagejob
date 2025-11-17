local Translations = {
    Target = {
        disposeBag = 'Afvalzak Pakken',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'In de Vrachtwagen Gooien',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Praat met de Vuilnisman',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Valsspelen Gedetecteerd :(',
        droppedWarn = 'Speler: %s is meer dan %s vectoren verwijderd van waar hij zou moeten zijn',
        not_employee = 'Speler %s probeerde de afvalbaan te starten maar is geen medewerker',
        already_started = 'Speler %s probeerde de afvalbaan te starten maar had deze al gestart; dit zou onmogelijk moeten zijn om twee keer te activeren',
        notActice = 'Speler: %s probeerde een route te krijgen maar was niet actief | Dit zou ALLEEN mogen gebeuren als Lua-triggers betrokken zijn',
        notEnoughBags = 'Speler: %s probeerde de volgende stop te bereiken maar had niet genoeg zakken verzameld | Dit zou ALLEEN mogen gebeuren als Lua-triggers betrokken zijn',
    },
    Notify = {
        nextStop = "Je halte is gemarkeerd op je GPS",
        doneWorking = "Je hebt je route afgerond! Breng de vrachtwagen terug naar het depot.",
        depositPaid = "Je hebt je borg voor de vrachtwagen betaald.",
        truckReturned = "Je hebt de vrachtwagen teruggebracht en je borg teruggekregen.",
        too_poor = "Je moet %s betalen om met de baan te beginnen",
        foundItem = "Je hebt een %s gevonden tijdens het verzamelen van afval!",
    },
    Menu = {
        header = "Afval Hoofdmenu",
        collect = 'Loon Ophalen',
        collectText = 'Haal hier je zuurverdiende loon op.',
        startJob = 'Ontvang Je Route',
        startJobText = 'Krijg een afvalinzamelingroute toegewezen.',
    }
}
if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
