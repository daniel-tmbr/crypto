import Combine
import Foundation
import Rest

public enum Wallet {
    public static func account<SnapshotConfig>(config: SnapshotConfig) -> BinanceEndpoint<AccountSnapshotParams, AccountSnapshot<SnapshotConfig.Response>>
    where SnapshotConfig: SnapshotRequestConfig {
        AccountSnapshotRequest<SnapshotConfig>(config: config).binanceEndpoint()
    }
    public static func coins() -> BinanceEndpoint<CoinParams, [Coin]> {
        CoinsRequest().binanceEndpoint()
    }
    public static func depositHistory() -> BinanceEndpoint<DepositHistoryParams, [Deposit]> {
        DepositHistoryRequest().binanceEndpoint()
    }
    public static func systemStatus() -> BinanceEndpoint<Void, SystemStatus> {
        SystemStatusRequest().binanceEndpoint()
    }
}

public enum Market {
    public static func candlestick() -> BinanceEndpoint<CandlestickParams, [Candlestick]> {
        let cs = CandlestickRequest().binanceEndpoint()
        return cs
    }
    public static func exchangeInfo() -> BinanceEndpoint<Void, ExchangeInfo> {
        ExchangeInfoRequest().binanceEndpoint()
    }
}
