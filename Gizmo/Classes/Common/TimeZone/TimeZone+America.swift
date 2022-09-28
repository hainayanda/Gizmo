//
//  TimeZone+America.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 28/9/22.
//

import Foundation

public extension TimeZone {
    
    // MARK: America
    
    enum America: String, CaseIterable {
        case adak = "America/Adak"
        case anchorage = "America/Anchorage"
        case anguilla = "America/Anguilla"
        case antigua = "America/Antigua"
        case araguaina = "America/Araguaina"
        case aruba = "America/Aruba"
        case asuncion = "America/Asuncion"
        case atikokan = "America/Atikokan"
        case bahia = "America/Bahia"
        case bahiaBanderas = "America/Bahia_Banderas"
        case barbados = "America/Barbados"
        case belem = "America/Belem"
        case belize = "America/Belize"
        case blancSablon = "America/Blanc-Sablon"
        case boaVista = "America/Boa_Vista"
        case bogota = "America/Bogota"
        case boise = "America/Boise"
        case cambridgeBay = "America/Cambridge_Bay"
        case campoGrande = "America/Campo_Grande"
        case cancun = "America/Cancun"
        case caracas = "America/Caracas"
        case cayenne = "America/Cayenne"
        case cayman = "America/Cayman"
        case chicago = "America/Chicago"
        case chihuahua = "America/Chihuahua"
        case costaRica = "America/Costa_Rica"
        case creston = "America/Creston"
        case cuiaba = "America/Cuiaba"
        case curacao = "America/Curacao"
        case danmarkshavn = "America/Danmarkshavn"
        case dawson = "America/Dawson"
        case dawsonCreek = "America/Dawson_Creek"
        case denver = "America/Denver"
        case detroit = "America/Detroit"
        case dominica = "America/Dominica"
        case edmonton = "America/Edmonton"
        case eirunepe = "America/Eirunepe"
        case elSalvador = "America/El_Salvador"
        case fortNelson = "America/Fort_Nelson"
        case fortaleza = "America/Fortaleza"
        case glaceBay = "America/Glace_Bay"
        case godthab = "America/Godthab"
        case gooseBay = "America/Goose_Bay"
        case grandTurk = "America/Grand_Turk"
        case grenada = "America/Grenada"
        case guadeloupe = "America/Guadeloupe"
        case guatemala = "America/Guatemala"
        case guayaquil = "America/Guayaquil"
        case guyana = "America/Guyana"
        case halifax = "America/Halifax"
        case havana = "America/Havana"
        case hermosillo = "America/Hermosillo"
        case inuvik = "America/Inuvik"
        case iqaluit = "America/Iqaluit"
        case jamaica = "America/Jamaica"
        case juneau = "America/Juneau"
        case kralendijk = "America/Kralendijk"
        case laPaz = "America/La_Paz"
        case lima = "America/Lima"
        case losAngeles = "America/Los_Angeles"
        case lowerPrinces = "America/Lower_Princes"
        case maceio = "America/Maceio"
        case managua = "America/Managua"
        case manaus = "America/Manaus"
        case marigot = "America/Marigot"
        case martinique = "America/Martinique"
        case matamoros = "America/Matamoros"
        case mazatlan = "America/Mazatlan"
        case menominee = "America/Menominee"
        case merida = "America/Merida"
        case metlakatla = "America/Metlakatla"
        case mexicoCity = "America/Mexico_City"
        case miquelon = "America/Miquelon"
        case moncton = "America/Moncton"
        case monterrey = "America/Monterrey"
        case montevideo = "America/Montevideo"
        case montreal = "America/Montreal"
        case montserrat = "America/Montserrat"
        case nassau = "America/Nassau"
        case newYork = "America/New_York"
        case nipigon = "America/Nipigon"
        case nome = "America/Nome"
        case noronha = "America/Noronha"
        case nuuk = "America/Nuuk"
        case ojinaga = "America/Ojinaga"
        case panama = "America/Panama"
        case pangnirtung = "America/Pangnirtung"
        case paramaribo = "America/Paramaribo"
        case phoenix = "America/Phoenix"
        case portAuPrince = "America/Port-au-Prince"
        case portOfSpain = "America/Port_of_Spain"
        case portoVelho = "America/Porto_Velho"
        case puertoRico = "America/Puerto_Rico"
        case puntaArenas = "America/Punta_Arenas"
        case rainyRiver = "America/Rainy_River"
        case rankinInlet = "America/Rankin_Inlet"
        case recife = "America/Recife"
        case regina = "America/Regina"
        case resolute = "America/Resolute"
        case rioBranco = "America/Rio_Branco"
        case santaIsabel = "America/Santa_Isabel"
        case santarem = "America/Santarem"
        case santiago = "America/Santiago"
        case santoDomingo = "America/Santo_Domingo"
        case saoPaulo = "America/Sao_Paulo"
        case scoresbysund = "America/Scoresbysund"
        case shiprock = "America/Shiprock"
        case sitka = "America/Sitka"
        case stBarthelemy = "America/St_Barthelemy"
        case stJohns = "America/St_Johns"
        case stKitts = "America/St_Kitts"
        case stLucia = "America/St_Lucia"
        case stThomas = "America/St_Thomas"
        case stVincent = "America/St_Vincent"
        case swiftCurrent = "America/Swift_Current"
        case tegucigalpa = "America/Tegucigalpa"
        case thule = "America/Thule"
        case thunderBay = "America/Thunder_Bay"
        case tijuana = "America/Tijuana"
        case toronto = "America/Toronto"
        case tortola = "America/Tortola"
        case vancouver = "America/Vancouver"
        case whitehorse = "America/Whitehorse"
        case winnipeg = "America/Winnipeg"
        case yakutat = "America/Yakutat"
        case yellowknife = "America/Yellowknife"
    }
    
    // MARK: America/Argentina
    
    enum Argentina: String, CaseIterable {
        case buenosAires = "America/Argentina/Buenos_Aires"
        case catamarca = "America/Argentina/Catamarca"
        case cordoba = "America/Argentina/Cordoba"
        case jujuy = "America/Argentina/Jujuy"
        case laRioja = "America/Argentina/La_Rioja"
        case mendoza = "America/Argentina/Mendoza"
        case rioGallegos = "America/Argentina/Rio_Gallegos"
        case salta = "America/Argentina/Salta"
        case sanJuan = "America/Argentina/San_Juan"
        case sanLuis = "America/Argentina/San_Luis"
        case tucuman = "America/Argentina/Tucuman"
        case ushuaia = "America/Argentina/Ushuaia"
    }
    
    // MARK: America/Indiana
    
    enum Indiana: String, CaseIterable {
        case indianapolis = "America/Indiana/Indianapolis"
        case knox = "America/Indiana/Knox"
        case marengo = "America/Indiana/Marengo"
        case petersburg = "America/Indiana/Petersburg"
        case tellCity = "America/Indiana/Tell_City"
        case vevay = "America/Indiana/Vevay"
        case vincennes = "America/Indiana/Vincennes"
        case winamac = "America/Indiana/Winamac"
    }
    
    // MARK: America/Kentucky
    
    enum Kentucky: String, CaseIterable {
        case louisville = "America/Kentucky/Louisville"
        case monticello = "America/Kentucky/Monticello"
    }
    
    // MARK: America/NorthDakota
    
    enum NorthDakota: String, CaseIterable {
        case beulah = "America/North_Dakota/Beulah"
        case center = "America/North_Dakota/Center"
        case newSalem = "America/North_Dakota/New_Salem"
    }
}
