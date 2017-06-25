//
//  StringExtension.swift
//  WebAPI
//
//  Created by Bobson on 2016/1/25.
//  Copyright © 2016年 Bobson. All rights reserved.
//

extension String {
    
    public subscript (i: Int) -> Character {
        let charAtIndex = self[index(startIndex, offsetBy:i)]
        return charAtIndex
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex
        let end = endIndex
        return String(self[Range(start..<end)])
    }
    
    public init<T>(type: T) {
        self = "\(Swift.type(of: type))"
    }
    
    public init<T>(type: T.Type) {
        self = "\(type.self)"
    }
    
    /**
     * 文字 to base64
     */
    public var toBase64String: String?
    {
        let text = self
        let data = text.data(using: String.Encoding.utf8);
        let base64 = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        return base64
    }
    
    /**
     * 文字 to decode Base64
     */
    public var toDecodeBase64String: String?
    {
        let text = self
        var xorString: String?
        
        if let decodedData = Data(base64Encoded: text, options: Data.Base64DecodingOptions(rawValue: 0))
        {
            xorString = String(data: decodedData, encoding: String.Encoding.utf8)
        }
        
        return xorString
    }
    
    /**
     * 取得XOR後的字串結果
     */
    fileprivate func xor(for key: NSString) -> String
    {
        var encryptedCString = ""
        let keyCount = key.length
        let input = self as NSString
        let inputCount = input.length
        
        for f in 0 ..< inputCount {
            
            let inputChar: unichar = input.character(at: f)
            let keyIndex = f % keyCount
            
            let keyChar: unichar = key.character(at: keyIndex)
            let encryptChar: unichar = inputChar ^ keyChar
            
            encryptedCString.append(String(describing: UnicodeScalar(encryptChar)))
        }
        
        return encryptedCString
    }
    
    /**
     Xor後，轉Base64
     
     - parameter xorKey: xorKey description
     
     - returns: return value description
     */
    public func encrypt(for xorKey: NSString) -> String?
    {
        let result = self.xor(for: xorKey).toBase64String
        return result
    }
    
    /**
     解碼Base64後，Xor
     
     - parameter xorKey: xorKey description
     
     - returns: return value description
     */
    public func decrypt(for xorKey: NSString) -> String?
    {
        let result = self.toDecodeBase64String?.xor(for: xorKey)
        return result
    }
    
    /**
     * Base64字串轉圖片
     */
    public var toPNGImage: UIImage?
    {
        let base64 = self
        var image: UIImage?
        
        if let pngData = Data(base64Encoded: base64, options: Data.Base64DecodingOptions(rawValue: 0))
        {
            image = UIImage(data: pngData)
        }
        
        return image
    }
    
    /**
     * 清除空白
     */
    public var trim: String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     * 是否符合RegEx
     */
    public func isMatch(_ pattern: String) -> Bool
    {
        var regex: NSRegularExpression? = nil
        
        do
        {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        }
        catch let error
        {
            print(error)
        }
        
        return regex?.firstMatch(in: self, options:[], range: NSMakeRange(0, utf16.count)) != nil
    }
    
    /**
     * 是否符合RegEx
     */
    public func matchString(_ pattern: String) -> String?
    {
        var regex: NSRegularExpression? = nil
        
        do
        {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        }
        catch let error
        {
            print(error)
        }

        
        guard let range = regex?.firstMatch(in: self, options:[], range: NSMakeRange(0, utf16.count))?.range else
        {
            return nil
        }
        
        let nsString = self as NSString
        let matchedString = nsString.substring(with: range)
        
        return matchedString
    }
    
    /**
     * 是否為Account
     */
    public var isAccount: Bool
    {
        return isMatch("^[a-z0-9]{4,16}")
    }
    
    /// 是否為Access類型的會員帳號
    public var isAccessAccount: Bool {
        return self.hasSuffix("@so-net.net.tw")
    }
    
    /**
     * 是否為Email
     */
    public var isEmail: Bool
    {
        return isMatch("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
    }
    
    /**
     * 是否為密碼(英數混合8 ~ 20字)
     */
    public var isPassword: Bool
    {
        return isMatch("^[0-9a-zA-Z]{8,20}$")
    }
    
    /**
     * 是否為身份證字號
     */
    public var isID: Bool
    {
        return isMatch("^[A-Za-z][1-2][0-9]{8}$")
    }
    
    /**
     * 是否為手機號碼
     */
    public var isMobilePhone: Bool
    {
        return isMatch("^09[0-9]{8}$")
    }
    
    /**
     * 是否為市話號碼
     */
    public func isPhoneWithRegion() -> Bool
    {
        return isMatch("^[0-9]{2,4}\\-[0-9]+$")
    }
    
    /**
     * 是否長度一致
     */
    public func isLength(_ count: Int) -> Bool
    {
        return self.characters.count == count
    }
    
    /**
     * 不是輸入英文或數字
     */
    public var isEnglishOrDigital: Bool
    {
        return isMatch("^([a-zA-Z0-9])+$")
    }
   
    /**
     * 是否為身份證字號
     */
    public func clearMatchString(_ pattern: String) -> String
    {
        guard let str = matchString(pattern) else {
            return self
        }
        
        let result = self.replacingOccurrences(of: str, with: "")
        
        return result
    }
    
    /**
     * 取得多國語言
     */
    public func localize(_ comment: String = "", defaultValue: String = " ") -> String
    {
        return NSLocalizedString(self, value: defaultValue, comment: comment)
    }
    
    /**
     轉Date
     
     - parameter dateformat:
     - parameter locale:
     
     - returns: NSDate
     */
    
    /// 轉Date
    ///
    /// - Parameters:
    ///   - format: "yyyy/MM/dd HH:mm:ss" or "yyy/MM/dd" (民國年)
    ///   - locale: 地區
    ///   - timeZone: 時區
    ///   - calendar: 日曆
    /// - Returns: Date
    public func toDate(_ format: String, locale: Locale, timeZone: TimeZone, calendar: Calendar = .current) -> Date?
    {
        let dateFormater = DateFormatter()
        
        dateFormater.locale = locale
        dateFormater.dateFormat = format
        dateFormater.timeZone = timeZone
        dateFormater.calendar = calendar
        
        return dateFormater.date(from: self)
    }
}
