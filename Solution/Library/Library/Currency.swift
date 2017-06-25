//
//  Currency.swift
//  WebAPI
//
//  Created by 劉柏賢 on 2017/6/21.
//  Copyright © 2017年 Bobson. All rights reserved.
//

public enum Currency: String {
    case chf = "CHF"
    case fjd = "FJD"
    case mxn = "MXN"
    case ars = "ARS"
    case qar = "QAR"
    case kzt = "KZT"
    case sar = "SAR"
    case inr = "INR"
    case vnd = "VND"
    case xpf = "XPF"
    case thb = "THB"
    case cny = "CNY"
    case aud = "AUD"
    case krw = "KRW"
    case ils = "ILS"
    case jpy = "JPY"
    case pln = "PLN"
    case gbp = "GBP"
    case idr = "IDR"
    case huf = "HUF"
    case php = "PHP"
    case kwd = "KWD"
    case `try` = "TRY"
    case rub = "RUB"
    case jod = "JOD"
    case isk = "ISK"
    case twd = "TWD"
    case hkd = "HKD"
    case aed = "AED"
    case eur = "EUR"
    case dkk = "DKK"
    case cad = "CAD"
    case usd = "USD"
    case myr = "MYR"
    case bgn = "BGN"
    case nok = "NOK"
    case ron = "RON"
    case sgd = "SGD"
    case ngn = "NGN"
    case omr = "OMR"
    case czk = "CZK"
    case pkr = "PKR"
    case pen = "PEN"
    case sek = "SEK"
    case nzd = "NZD"
    case brl = "BRL"
    case uah = "UAH"
    case bhd = "BHD"
    
    /// 取得目前幣別 (USD is default)
    public static var current: Currency {
        return Currency(rawValue: Locale.current.currencyCode ?? "") ?? .usd
    }
}
