local Translations = {
    Target = {
        disposeBag = 'Çöp Torbasını Al',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Kamyona At',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Çöpçüyle Konuş',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Hile Tespit Edildi :(',
        droppedWarn = 'Oyuncu: %s, olması gereken yerden %s vektör daha uzakta bulundu',
        not_employee = 'Oyuncu %s çöp işine başlamaya çalıştı ancak çalışan değil',
        already_started = 'Oyuncu %s çöp işine başlamaya çalıştı ama zaten başlatmıştı; bunun iki kez tetiklenmesi imkânsız olmalı',
        notActice = 'Oyuncu: %s bir rota almayı denedi ancak aktif değildi | Bu sadece Lua tetikleyicileriyle mümkün olmalı',
        notEnoughBags = 'Oyuncu: %s bir sonraki durağa gitmeye çalıştı ama yeterli torba toplamamış | Bu sadece Lua tetikleyicileriyle mümkün olmalı',
    },
    Notify = {
        nextStop = "Durak GPS'ine işlendi",
        doneWorking = "Rotanı tamamladın! Kamyonu garaja geri götür.",
        depositPaid = "Kamyon için depozitonu ödedin.",
        truckReturned = "Kamyonu iade ettin ve depozitonu geri aldın.",
        too_poor = "İşe başlamak için %s ödemelisin",
        foundItem = "Çöp toplarken bir %s buldun!",
    },
    Menu = {
        header = "Çöp Ana Menüsü",
        collect = 'Maaşını Al',
        collectText = 'Buradan emeklerinin karşılığını al.',
        startJob = 'Rotanı Al',
        startJobText = 'Çöp toplama rotanı al.',
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
