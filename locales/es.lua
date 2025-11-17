local Translations = {
    Target = {
        disposeBag = 'Recoger Bolsa de Basura',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Tirar en el Camión',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Hablar con el Basurero',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Trampa Detectada :(',
        droppedWarn = 'Jugador: %s fue encontrado a más de %s vectores de distancia de donde debería estar',
        not_employee = 'El jugador %s intentó iniciar el trabajo de basura pero no es un empleado',
        already_started = 'El jugador %s intentó iniciar el trabajo de basura pero ya lo había iniciado; debería ser imposible activarlo dos veces',
        notActice = 'Jugador: %s intentó obtener una ruta pero no estaba activo | Esto solo debería ocurrir si hay triggers de Lua involucrados',
        notEnoughBags = 'Jugador: %s intentó ir a la siguiente parada pero no había recogido suficientes bolsas | Esto solo debería ocurrir si hay triggers de Lua involucrados',
    },
    Notify = {
        nextStop = "Tu parada ha sido marcada en tu GPS",
        doneWorking = "¡Has terminado tu ruta! Devuelve el camión al depósito.",
        depositPaid = "Has pagado tu depósito por el camión.",
        truckReturned = "Has devuelto el camión y recuperado tu depósito.",
        too_poor = "Necesitas pagar %s para comenzar el trabajo",
        foundItem = "¡Encontraste un %s mientras recogías basura!",
    },
    Menu = {
        header = "Menú Principal de Basura",
        collect = 'Cobrar Salario',
        collectText = 'Cobra aquí tu salario bien ganado.',
        startJob = 'Obtener Tu Ruta',
        startJobText = 'Obtén una ruta asignada para recolectar basura.',
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
