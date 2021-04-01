import Foundation

public enum BinanceErrorCode: RawRepresentable, Decodable {
    /// WAF Limit (Web Application Firewall) has been violated
    case wafLimitViolation // 403

    /// Breaking a request rate limit
    case rateLimitViolation // 429

    /// An IP has been auto-banned for continuing to send requests after receiving 429 codes.
    case banned // 418

    /// An unknown error occured while processing the request.
    case unknown // -1000

    /// Internal error; unable to process your request. Please try again.
    case disconnected // -1001

    /// You are not authorized to execute this request.
    case unauthorized // -1002

    /// Too many requests queued.
    /// Too much request weight used; please use the websocket for live updates to avoid polling the API.
    /// Too much request weight used; current limit is %s request weight per %s %s. Please use the websocket for live updates to avoid polling the API.
    /// Way too much request weight used; IP banned until %s. Please use the websocket for live updates to avoid bans.
    case tooManyRequest // -1003

    /// An unexpected response was received from the message bus. Execution status unknown.
    case unexpectedResp // -1006

    /// Timeout waiting for response from backend server. Send status unknown; execution status unknown.
    case timeout // -1007

    /// Unsupported order combination.
    case unknownOrderComposition // -1014

    /// Too many new orders.
    /// Too many new orders; current limit is %s orders per %s.
    case tooManyOrders // -1015

    /// This service is no longer available.
    case serviceShuttingDown // -1016

    /// This operation is not supported.
    case unsupportedOperation // -1020

    /// Timestamp for this request is outside of the recvWindow.
    /// Timestamp for this request was 1000ms ahead of the server's time.
    case invalidTimestamp // -1021

    /// Signature for this request is not valid.
    case invalidSignature // -1022

    /// Not found, authenticated, or authorized
    /// This replaces error code -1999
    case notFound // -1099

    /// Illegal characters found in a parameter.
    /// Illegal characters found in parameter %s; legal range is %s.
    case illegalChars // -1100

    /// Too many parameters sent for this endpoint.
    /// Too many parameters; expected %s and received %s.
    /// Duplicate values for a parameter detected.
    case tooManyParameters // -1101

    /// A mandatory parameter was not sent, was empty/null, or malformed.
    /// Mandatory parameter %s was not sent, was empty/null, or malformed.
    /// Param %s or %s must be sent, but both were empty/null!
    case mandatoryParamEmptyOrMalformed // -1102

    /// An unknown parameter was sent.
    case unknownParam // -1103

    /// Not all sent parameters were read.
    /// Not all sent parameters were read; read %s parameter(s) but was sent %s.
    case unreadParameters // -1104

    /// A parameter was empty.
    /// Parameter %s was empty.
    case paramEmpty // -1105

    /// A parameter was sent when not required.
    /// Parameter %s sent when not required.
    case paramNotRequired // -1106

    /// Precision is over the maximum defined for this asset.
    case badPrecision // -1111

    /// No orders on book for symbol.
    case noDepth // -1112

    /// TimeInForce parameter sent when not required.
    case tifNotRequired // -1114

    /// Invalid timeInForce.
    case invalidTif // -1115

    /// Invalid orderType.
    case invalidOrderType // -1116

    /// Invalid side.
    case invalidSide // -1117

    /// New client order ID was empty.
    case emptyNewClOrdId // -1118

    /// Original client order ID was empty.
    case emptyOrgClOrdId // -1119

    /// Invalid interval.
    case badInterval // -1120

    /// Invalid symbol.
    case badSymbol // -1121

    /// This listenKey does not exist.
    case invalidListenKey // -1125

    /// Lookup interval is too big.
    /// More than %s hours between startTime and endTime.
    case moreThanXxHours // -1127

    /// Combination of optional parameters invalid.
    case optionalParamsBadCombo // -1128

    /// Invalid data sent for a parameter.
    /// Data sent for paramter %s is not valid.
    case invalidParameter // -1130

    /// recvWindow must be less than 60000
    case badRecvWindow // -1131

    /// NEW_ORDER_REJECTED
    case newOrderRejected // -2010

    /// CANCEL_REJECTED
    case cancelRejected // -2011

    /// Order does not exist.
    case noSuchOrder // -2013

    /// API-key format invalid.
    case badApiKeyFmt // -2014

    /// Invalid API-key, IP, or permissions for action.
    case rejectedMbxKey // -2015

    /// No trading window could be found for the symbol. Try ticker/24hrs instead.
    case noTradingWindow // -2016

    /// Margin account are not allowed to trade this trading pair.
    case pairAdminBanTrade // -3021

    /// You account's trading is banned.
    case accountBanTrade // -3022

    /// You can't transfer out/place order under current margin level.
    case warningMarginLevel // -3023

    /// The unpaid debt is too small after this repayment.
    case fewLiabilityLeft // -3024

    /// Your input date is invalid.
    case invalidEffectiveTime // -3025

    /// Your input param is invalid.
    case validationFailed // -3026

    /// Not a valid margin asset.
    case notValidMarginAsset // -3027

    /// Not a valid margin pair.
    case notValidMarginPair // -3028

    /// Transfer failed.
    case transferFailed // -3029

    /// This account is not allowed to repay.
    case accountBanRepay // -3036

    /// PNL is clearing. Wait a second.
    case pnlClearing // -3037

    /// Listen key not found.
    case listenKeyNotFound // -3038

    /// PriceIndex not available for this margin pair.
    case priceIndexNotFound // -3042

    /// This function is only available for invited users.
    case notWhitelistUser // -3999

    /// Invalid operation.
    case capitalInvalid // -4001

    /// Invalid get.
    case capitalIg // -4002

    /// Your input email is invalid.
    case capitalIev // -4003

    /// You don't login or auth.
    case capitalUa // -4004

    /// Too many new requests.
    case capaitalTooManyRequest // -4005

    /// Support main account only.
    case capitalOnlySupportPrimaryAccount // -4006

    /// Address validation is not passed.
    case capitalAddressVerificationNotPass // -4007

    /// Address tag validation is not passed.
    case capitalAddressTagVerificationNotPass // -4008

    /// Daily product not exists.
    case dailyProductNotExist // -6001

    /// Product not exist or you don't have permission
    case dailyProductNotAccessible // -6003

    /// Product not in purchase status
    case dailyProductNotPurchasable // -6004

    /// Smaller than min purchase limit
    case dailyLowerThanMinPurchaseLimit // -6005

    /// Redeem amount error
    case dailyRedeemAmountError // -6006

    /// Not in redeem time
    case dailyRedeemTimeError // -6007

    /// Product not in redeem status
    case dailyProductNotRedeemable // -6008

    /// Request frequency too high
    case requestFrequencyTooHigh // -6009

    /// Exceeding the maximum num allowed to purchase per user
    case exceededUserPurchaseLimit // -6011

    /// Balance not enough
    case balanceNotEnough // -6012

    /// Purchasing failed
    case purchasingFailed // -6013

    /// Exceed up-limit allowed to purchased
    case updateFailed // -6014

    /// Empty request body
    case emptyRequestBody // -6015

    /// Parameter err
    case paramsErr // -6016

    /// Not in whitelist
    case notInWhitelist // -6017

    /// Asset not enough
    case assetNotEnough // -6018

    /// Need confirm
    case pending // -6019

    /// Filter failures
    case filter(Int)

    /// Fallback for future values
    case other(Int)

    // MARK: - RawRepresentable conformance

    public init?(rawValue: Int) {
        switch rawValue {
        case Raw.wafLimitViolation: self = .wafLimitViolation
        case Raw.rateLimitViolation: self = .rateLimitViolation
        case Raw.banned: self = .banned
        case Raw.unknown: self = .unknown
        case Raw.disconnected: self = .disconnected
        case Raw.unauthorized: self = .unauthorized
        case Raw.tooManyRequest: self = .tooManyRequest
        case Raw.unexpectedResp: self = .unexpectedResp
        case Raw.timeout: self = .timeout
        case Raw.unknownOrderComposition: self = .unknownOrderComposition
        case Raw.tooManyOrders: self = .tooManyOrders
        case Raw.serviceShuttingDown: self = .serviceShuttingDown
        case Raw.unsupportedOperation: self = .unsupportedOperation
        case Raw.invalidTimestamp: self = .invalidTimestamp
        case Raw.invalidSignature: self = .invalidSignature
        case Raw.notFound: self = .notFound
        case Raw.illegalChars: self = .illegalChars
        case Raw.tooManyParameters: self = .tooManyParameters
        case Raw.mandatoryParamEmptyOrMalformed: self = .mandatoryParamEmptyOrMalformed
        case Raw.unknownParam: self = .unknownParam
        case Raw.unreadParameters: self = .unreadParameters
        case Raw.paramEmpty: self = .paramEmpty
        case Raw.paramNotRequired: self = .paramNotRequired
        case Raw.badPrecision: self = .badPrecision
        case Raw.noDepth: self = .noDepth
        case Raw.tifNotRequired: self = .tifNotRequired
        case Raw.invalidTif: self = .invalidTif
        case Raw.invalidOrderType: self = .invalidOrderType
        case Raw.invalidSide: self = .invalidSide
        case Raw.emptyNewClOrdId: self = .emptyNewClOrdId
        case Raw.emptyOrgClOrdId: self = .emptyOrgClOrdId
        case Raw.badInterval: self = .badInterval
        case Raw.badSymbol: self = .badSymbol
        case Raw.invalidListenKey: self = .invalidListenKey
        case Raw.moreThanXxHours: self = .moreThanXxHours
        case Raw.optionalParamsBadCombo: self = .optionalParamsBadCombo
        case Raw.invalidParameter: self = .invalidParameter
        case Raw.badRecvWindow: self = .badRecvWindow
        case Raw.newOrderRejected: self = .newOrderRejected
        case Raw.cancelRejected: self = .cancelRejected
        case Raw.noSuchOrder: self = .noSuchOrder
        case Raw.badApiKeyFmt: self = .badApiKeyFmt
        case Raw.rejectedMbxKey: self = .rejectedMbxKey
        case Raw.noTradingWindow: self = .noTradingWindow
        case Raw.pairAdminBanTrade: self = .pairAdminBanTrade
        case Raw.accountBanTrade: self = .accountBanTrade
        case Raw.warningMarginLevel: self = .warningMarginLevel
        case Raw.fewLiabilityLeft: self = .fewLiabilityLeft
        case Raw.invalidEffectiveTime: self = .invalidEffectiveTime
        case Raw.validationFailed: self = .validationFailed
        case Raw.notValidMarginAsset: self = .notValidMarginAsset
        case Raw.notValidMarginPair: self = .notValidMarginPair
        case Raw.transferFailed: self = .transferFailed
        case Raw.accountBanRepay: self = .accountBanRepay
        case Raw.pnlClearing: self = .pnlClearing
        case Raw.listenKeyNotFound: self = .listenKeyNotFound
        case Raw.priceIndexNotFound: self = .priceIndexNotFound
        case Raw.notWhitelistUser: self = .notWhitelistUser
        case Raw.capitalInvalid: self = .capitalInvalid
        case Raw.capitalIg: self = .capitalIg
        case Raw.capitalIev: self = .capitalIev
        case Raw.capitalUa: self = .capitalUa
        case Raw.capaitalTooManyRequest: self = .capaitalTooManyRequest
        case Raw.capitalOnlySupportPrimaryAccount: self = .capitalOnlySupportPrimaryAccount
        case Raw.capitalAddressVerificationNotPass: self = .capitalAddressVerificationNotPass
        case Raw.capitalAddressTagVerificationNotPass: self = .capitalAddressTagVerificationNotPass
        case Raw.dailyProductNotExist: self = .dailyProductNotExist
        case Raw.dailyProductNotAccessible: self = .dailyProductNotAccessible
        case Raw.dailyProductNotPurchasable: self = .dailyProductNotPurchasable
        case Raw.dailyLowerThanMinPurchaseLimit: self = .dailyLowerThanMinPurchaseLimit
        case Raw.dailyRedeemAmountError: self = .dailyRedeemAmountError
        case Raw.dailyRedeemTimeError: self = .dailyRedeemTimeError
        case Raw.dailyProductNotRedeemable: self = .dailyProductNotRedeemable
        case Raw.requestFrequencyTooHigh: self = .requestFrequencyTooHigh
        case Raw.exceededUserPurchaseLimit: self = .exceededUserPurchaseLimit
        case Raw.balanceNotEnough: self = .balanceNotEnough
        case Raw.purchasingFailed: self = .purchasingFailed
        case Raw.updateFailed: self = .updateFailed
        case Raw.emptyRequestBody: self = .emptyRequestBody
        case Raw.paramsErr: self = .paramsErr
        case Raw.notInWhitelist: self = .notInWhitelist
        case Raw.assetNotEnough: self = .assetNotEnough
        case Raw.pending: self = .pending
        case Raw.filter: self = .filter(rawValue)
        default: self = .other(rawValue)
        }
    }

    public var rawValue: Int {
        switch self {
        case .wafLimitViolation: return Raw.wafLimitViolation
        case .rateLimitViolation: return Raw.rateLimitViolation
        case .banned: return Raw.banned
        case .unknown: return Raw.unknown
        case .disconnected: return Raw.disconnected
        case .unauthorized: return Raw.unauthorized
        case .tooManyRequest: return Raw.tooManyRequest
        case .unexpectedResp: return Raw.unexpectedResp
        case .timeout: return Raw.timeout
        case .unknownOrderComposition: return Raw.unknownOrderComposition
        case .tooManyOrders: return Raw.tooManyOrders
        case .serviceShuttingDown: return Raw.serviceShuttingDown
        case .unsupportedOperation: return Raw.unsupportedOperation
        case .invalidTimestamp: return Raw.invalidTimestamp
        case .invalidSignature: return Raw.invalidSignature
        case .notFound: return Raw.notFound
        case .illegalChars: return Raw.illegalChars
        case .tooManyParameters: return Raw.tooManyParameters
        case .mandatoryParamEmptyOrMalformed: return Raw.mandatoryParamEmptyOrMalformed
        case .unknownParam: return Raw.unknownParam
        case .unreadParameters: return Raw.unreadParameters
        case .paramEmpty: return Raw.paramEmpty
        case .paramNotRequired: return Raw.paramNotRequired
        case .badPrecision: return Raw.badPrecision
        case .noDepth: return Raw.noDepth
        case .tifNotRequired: return Raw.tifNotRequired
        case .invalidTif: return Raw.invalidTif
        case .invalidOrderType: return Raw.invalidOrderType
        case .invalidSide: return Raw.invalidSide
        case .emptyNewClOrdId: return Raw.emptyNewClOrdId
        case .emptyOrgClOrdId: return Raw.emptyOrgClOrdId
        case .badInterval: return Raw.badInterval
        case .badSymbol: return Raw.badSymbol
        case .invalidListenKey: return Raw.invalidListenKey
        case .moreThanXxHours: return Raw.moreThanXxHours
        case .optionalParamsBadCombo: return Raw.optionalParamsBadCombo
        case .invalidParameter: return Raw.invalidParameter
        case .badRecvWindow: return Raw.badRecvWindow
        case .newOrderRejected: return Raw.newOrderRejected
        case .cancelRejected: return Raw.cancelRejected
        case .noSuchOrder: return Raw.noSuchOrder
        case .badApiKeyFmt: return Raw.badApiKeyFmt
        case .rejectedMbxKey: return Raw.rejectedMbxKey
        case .noTradingWindow: return Raw.noTradingWindow
        case .pairAdminBanTrade: return Raw.pairAdminBanTrade
        case .accountBanTrade: return Raw.accountBanTrade
        case .warningMarginLevel: return Raw.warningMarginLevel
        case .fewLiabilityLeft: return Raw.fewLiabilityLeft
        case .invalidEffectiveTime: return Raw.invalidEffectiveTime
        case .validationFailed: return Raw.validationFailed
        case .notValidMarginAsset: return Raw.notValidMarginAsset
        case .notValidMarginPair: return Raw.notValidMarginPair
        case .transferFailed: return Raw.transferFailed
        case .accountBanRepay: return Raw.accountBanRepay
        case .pnlClearing: return Raw.pnlClearing
        case .listenKeyNotFound: return Raw.listenKeyNotFound
        case .priceIndexNotFound: return Raw.priceIndexNotFound
        case .notWhitelistUser: return Raw.notWhitelistUser
        case .capitalInvalid: return Raw.capitalInvalid
        case .capitalIg: return Raw.capitalIg
        case .capitalIev: return Raw.capitalIev
        case .capitalUa: return Raw.capitalUa
        case .capaitalTooManyRequest: return Raw.capaitalTooManyRequest
        case .capitalOnlySupportPrimaryAccount: return Raw.capitalOnlySupportPrimaryAccount
        case .capitalAddressVerificationNotPass: return Raw.capitalAddressVerificationNotPass
        case .capitalAddressTagVerificationNotPass: return Raw.capitalAddressTagVerificationNotPass
        case .dailyProductNotExist: return Raw.dailyProductNotExist
        case .dailyProductNotAccessible: return Raw.dailyProductNotAccessible
        case .dailyProductNotPurchasable: return Raw.dailyProductNotPurchasable
        case .dailyLowerThanMinPurchaseLimit: return Raw.dailyLowerThanMinPurchaseLimit
        case .dailyRedeemAmountError: return Raw.dailyRedeemAmountError
        case .dailyRedeemTimeError: return Raw.dailyRedeemTimeError
        case .dailyProductNotRedeemable: return Raw.dailyProductNotRedeemable
        case .requestFrequencyTooHigh: return Raw.requestFrequencyTooHigh
        case .exceededUserPurchaseLimit: return Raw.exceededUserPurchaseLimit
        case .balanceNotEnough: return Raw.balanceNotEnough
        case .purchasingFailed: return Raw.purchasingFailed
        case .updateFailed: return Raw.updateFailed
        case .emptyRequestBody: return Raw.emptyRequestBody
        case .paramsErr: return Raw.paramsErr
        case .notInWhitelist: return Raw.notInWhitelist
        case .assetNotEnough: return Raw.assetNotEnough
        case .pending: return Raw.pending
        case .filter(let value): return value
        case .other(let value): return value
        }
    }

    private struct Raw {
        static let wafLimitViolation = 403
        static let rateLimitViolation = 429
        static let banned = 418
        static let unknown = -1000
        static let disconnected = -1001
        static let unauthorized = -1002
        static let tooManyRequest = -1003
        static let unexpectedResp = -1006
        static let timeout = -1007
        static let unknownOrderComposition = -1014
        static let tooManyOrders = -1015
        static let serviceShuttingDown = -1016
        static let unsupportedOperation = -1020
        static let invalidTimestamp = -1021
        static let invalidSignature = -1022
        static let notFound = -1099
        static let illegalChars = -1100
        static let tooManyParameters = -1101
        static let mandatoryParamEmptyOrMalformed = -1102
        static let unknownParam = -1103
        static let unreadParameters = -1104
        static let paramEmpty = -1105
        static let paramNotRequired = -1106
        static let badPrecision = -1111
        static let noDepth = -1112
        static let tifNotRequired = -1114
        static let invalidTif = -1115
        static let invalidOrderType = -1116
        static let invalidSide = -1117
        static let emptyNewClOrdId = -1118
        static let emptyOrgClOrdId = -1119
        static let badInterval = -1120
        static let badSymbol = -1121
        static let invalidListenKey = -1125
        static let moreThanXxHours = -1127
        static let optionalParamsBadCombo = -1128
        static let invalidParameter = -1130
        static let badRecvWindow = -1131
        static let newOrderRejected = -2010
        static let cancelRejected = -2011
        static let noSuchOrder = -2013
        static let badApiKeyFmt = -2014
        static let rejectedMbxKey = -2015
        static let noTradingWindow = -2016
        static let pairAdminBanTrade = -3021
        static let accountBanTrade = -3022
        static let warningMarginLevel = -3023
        static let fewLiabilityLeft = -3024
        static let invalidEffectiveTime = -3025
        static let validationFailed = -3026
        static let notValidMarginAsset = -3027
        static let notValidMarginPair = -3028
        static let transferFailed = -3029
        static let accountBanRepay = -3036
        static let pnlClearing = -3037
        static let listenKeyNotFound = -3038
        static let priceIndexNotFound = -3042
        static let notWhitelistUser = -3999
        static let capitalInvalid = -4001
        static let capitalIg = -4002
        static let capitalIev = -4003
        static let capitalUa = -4004
        static let capaitalTooManyRequest = -4005
        static let capitalOnlySupportPrimaryAccount = -4006
        static let capitalAddressVerificationNotPass = -4007
        static let capitalAddressTagVerificationNotPass = -4008
        static let dailyProductNotExist = -6001
        static let dailyProductNotAccessible = -6003
        static let dailyProductNotPurchasable = -6004
        static let dailyLowerThanMinPurchaseLimit = -6005
        static let dailyRedeemAmountError = -6006
        static let dailyRedeemTimeError = -6007
        static let dailyProductNotRedeemable = -6008
        static let requestFrequencyTooHigh = -6009
        static let exceededUserPurchaseLimit = -6011
        static let balanceNotEnough = -6012
        static let purchasingFailed = -6013
        static let updateFailed = -6014
        static let emptyRequestBody = -6015
        static let paramsErr = -6016
        static let notInWhitelist = -6017
        static let assetNotEnough = -6018
        static let pending = -6019
        static let filter = (-9999)...(-9000)
    }
}
