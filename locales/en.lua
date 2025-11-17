local Translations = {
    Target = {
        disposeBag = 'Grab Garbage Bag',
        disposeBagIcon = 'fas fa-trash',
        tossInTruck = 'Throw In The Truck',
        tossInTruckIcon = 'fas fa-trash',
        talk = 'Talk To Garbageman',
        talkIcon = 'fas fa-comment',
    },
    error = {
        Dropped = 'Cheating Detected :(',
        droppedWarn = 'Player: %s Was Found More Than %s Vectors Away From Where They Should Be',
        not_employee = 'Player %s Tried To Start The Garbage Job But Is Not An Employee',
        already_started = 'Player %s Tried To Start The Garbage Job But Had Already Started It, Should be impossible to trigger this twice',
        notActice = 'Player: %s Tried To Get A Route But Wasnt Active  | This should ONLY happen if lua triggers are involved',
        notEnoughBags = 'Player: %s Tried To Get Next Stop But Hadnt Collected Enough Bags | This should ONLY happen if lua triggers are involved',
    },
    Notify = {
        nextStop = "Your Stop Has Been Marked on Your GPS",
        doneWorking = "You have finished your route! Return the truck to the depot.",
        depositPaid = "You have paid your deposit for the truck.",
        truckReturned = "You have returned the truck and received your deposit back.",
        too_poor = "You Need To Pay %s To Start The Job",
        foundItem = "You found a %s while collecting garbage!",
    },
    Menu = {
        header = "Garbage Main Menu",
        collect = 'Collect Paycheck',
        collectText = 'Collect your hard earned paycheck here.',
        startJob = 'Get Your Route',
        startJobText = 'Get assigned a garbage collection route.',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
