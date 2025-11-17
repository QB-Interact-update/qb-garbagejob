local Translations = {
    Target = {
        disposeBag = 'Prendre le Sac Poubelle',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Jeter dans le Camion',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Parler à l’Éboueur',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Tricherie Détectée :(',
        droppedWarn = 'Joueur : %s a été trouvé à plus de %s vecteurs de distance de l’endroit où il devrait être',
        not_employee = 'Le joueur %s a essayé de commencer le travail de ramassage mais n’est pas employé',
        already_started = 'Le joueur %s a essayé de commencer le travail de ramassage mais l’avait déjà lancé ; cela devrait être impossible à déclencher deux fois',
        notActice = 'Joueur : %s a essayé d’obtenir un itinéraire mais n’était pas actif | Cela ne devrait arriver QUE si des déclencheurs Lua sont impliqués',
        notEnoughBags = 'Joueur : %s a essayé d’aller à l’arrêt suivant mais n’avait pas ramassé assez de sacs | Cela ne devrait arriver QUE si des déclencheurs Lua sont impliqués',
    },
    Notify = {
        nextStop = "Votre arrêt a été marqué sur votre GPS",
        doneWorking = "Vous avez terminé votre tournée ! Ramenez le camion au dépôt.",
        depositPaid = "Vous avez payé votre dépôt pour le camion.",
        truckReturned = "Vous avez rendu le camion et récupéré votre dépôt.",
        too_poor = "Vous devez payer %s pour commencer le travail",
        foundItem = "Vous avez trouvé un %s en ramassant les ordures !",
    },
    Menu = {
        header = "Menu Principal des Ordures",
        collect = 'Encaisser Votre Paie',
        collectText = 'Encaissez ici votre salaire durement gagné.',
        startJob = 'Obtenir Votre Tournée',
        startJobText = 'Obtenez une tournée de collecte des ordures attribuée.',
    }
}

if GetConvar('qb_locale', 'en') == 'fr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
