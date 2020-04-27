import Foundation

public enum FormContent {
  public struct URLEncoded {
    public private(set) var storage = [String: String]()

    static func parse(_ string: String) -> [String: String] {
      let percentEncoded = string.replacingOccurrences(of: "+", with: "%20")
      let pairs: [(Substring, Substring)] = percentEncoded
        .split(separator: "&")
        .map {
          let pair = $0.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
          return (pair[0], pair[1])
        }

      return pairs.reduce([:]) { result, pair in
        var newResult = result
        newResult[String(pair.0)] = pair.1.removingPercentEncoding ?? String(pair.1)
        return newResult
      }
    }
  }
}

extension FormContent.URLEncoded: ExpressibleByStringLiteral {
  public init(_ string: String) {
    self = .init(storage: FormContent.URLEncoded.parse(string))
  }

  public init(stringLiteral: String) {
    self = .init(storage: FormContent.URLEncoded.parse(stringLiteral))
  }
}
