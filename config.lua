Config = {}

Config.ATM_Models = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}

Config.ATMMinigame = {
    TotalRounds = 3,              -- Kaç tur tamamlanırsa başarı
    SequenceLength = 4,           -- Her turda kaç tuşluk kombinasyon
    StartTimer = 60,              -- Toplam süre (saniye)
    StabilityMax = 100,           -- Yeşil barın maksimum değeri
    StabilityDrainPerSec = 1.2,   -- Her saniye bar ne kadar azalır
    CorrectGain = 6,              -- Doğru tuşta bar ne kadar artar
    WrongPenalty = 12             -- Yanlış tuşta bar ne kadar azalır
}

Config.MinReward = 250              -- Minimum nakit
Config.MaxReward = 600              -- Maksimum nakit
Config.Cooldown = 120               -- Aynı oyuncu tekrar denemeden önce (saniye)