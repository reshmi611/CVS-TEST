//
//  FlikerImageTestTests.swift
// FlikerImageTest
//
//  Created by Reshmi Divi on 26/09/24.
//

import XCTest
@testable import FlikerImageTest

final class FlikerImageTestTests: XCTestCase {
    var viewModel: ImageListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    @MainActor func testViewModelArray() throws {
        viewModel.images = [Item(title: "", link: "", media: Media(m: ""), dateTaken: "", description: "", published: "", author: "", authorID: "", tags: "")]
        XCTAssertTrue(viewModel.images.isEmpty)
    }
    @MainActor func testViewModelSearchText() throws {
      
        viewModel.searchText = "test"
        XCTAssertTrue(!viewModel.searchText.isEmpty)
    }


}
