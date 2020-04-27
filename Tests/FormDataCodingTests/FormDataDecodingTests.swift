import XCTest
@testable import FormDataCoding

struct Country: Decodable {
  var name: String
  var population: Int
  var commonWealth: Bool
}

class FormDataDecodingTests: XCTestCase {
    var decoder: FormDataDecoder!

    override func setUp() {
        self.decoder = FormDataDecoder()
    }

  func testDecodeSuccess() {
    let query = "name=France&population=13000000&commonWealth=false"
    let data = query.data(using: .utf8)

    let value = try! decoder.decode(Country.self, from: data!)
    XCTAssertEqual(value.name, "France")
  }

  func testDecodeFailure() {
     let query = "name=France&population=yes&commonWealth=false"
     let data = query.data(using: .utf8)

     let value = try? decoder.decode(Country.self, from: data!)
     XCTAssertNil(value)
   }
}
