local Translations = {
    Target = {
        disposeBag = 'التقاط كيس القمامة',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'إلقاء في الشاحنة',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'التحدث إلى جامع القمامة',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'تم الكشف عن غش :(',
        droppedWarn = 'اللاعب: %s تم العثور عليه على بعد أكثر من %s متجهات من المكان الذي يجب أن يكون فيه',
        not_employee = 'اللاعب %s حاول بدء وظيفة جمع القمامة لكنه ليس موظفًا',
        already_started = 'اللاعب %s حاول بدء وظيفة جمع القمامة لكنه قد بدأها بالفعل، لا ينبغي أن يكون من الممكن تشغيل هذا مرتين',
        notActice = 'اللاعب: %s حاول الحصول على مسار لكنه لم يكن نشطًا | يجب أن يحدث هذا فقط إذا تم تضمين مشغلات lua',
        notEnoughBags = 'اللاعب: %s حاول الحصول على التوقف التالي لكنه لم يجمع ما يكفي من الأكياس | يجب أن يحدث هذا فقط إذا تم تضمين مشغلات lua',
    },
    Notify = {
        nextStop = "تم تحديد محطتك على نظام GPS الخاص بك",
        doneWorking = "لقد أنهيت مسارك! أعد الشاحنة إلى المستودع.",
        depositPaid = "لقد دفعت عربون الشاحنة.",
        truckReturned = "لقد أعدت الشاحنة واستلمت عربونك مرة أخرى.",
        too_poor = "تحتاج إلى دفع %s لبدء الوظيفة",
        foundItem = "لقد وجدت %s أثناء جمع القمامة!",
    },
    Menu = {
        header = "القائمة الرئيسية للقمامة",
        collect = 'جمع الراتب',
        collectText = 'اجمع راتبك المكتسب بشق الأنفس هنا.',
        startJob = 'احصل على مسارك',
        startJobText = 'احصل على تعيين مسار جمع القمامة.',
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
