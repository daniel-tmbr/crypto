import Foundation

public enum Wallet {
    public static func account<SnapshotConfig>(config: SnapshotConfig) -> BinanceRequest<AccountSnapshotParams, AccountSnapshot<SnapshotConfig.Response>>
    where SnapshotConfig: SnapshotRequestConfig {
        AccountSnapshotRequest<SnapshotConfig>(config: config).binanceApiRequest()
    }
    public static func coins() -> BinanceRequest<CoinParams, [Coin]> {
        CoinsRequest().binanceApiRequest()
    }
    public static func depositHistory() -> BinanceRequest<DepositHistoryParams, [Deposit]> {
        DepositHistoryRequest().binanceApiRequest()
    }
    public static func systemStatus() -> BinanceRequest<Void, SystemStatus> {
        SystemStatusRequest().binanceApiRequest()
    }
}

public enum Market {
    public static func candlestick() -> BinanceRequest<CandlestickParams, [Candlestick]> {
        CandlestickRequest().binanceApiRequest()
    }
    public static func exchangeInfo() -> BinanceRequest<Void, ExchangeInfo> {
        ExchangeInfoRequest().binanceApiRequest()
    }
}
