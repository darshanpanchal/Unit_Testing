//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Darshan on 27/09/21.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {
    func test_canInit() throws{
        
        _ = try makeSut()
       
    }
    func test_ViewDidLoad_settitles() throws{
    
        let sut = try makeSut()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Home")
    }
    func test_ViewDidLoad_ConfiguresTableViews() throws{
    
        let sut = try makeSut()
        sut.loadViewIfNeeded()
        XCTAssertIdentical(sut.tableView.delegate,sut)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    func test_ViewDidLoad_initialSet() throws{
    
        let sut = try makeSut()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    func test_ViewDidLoad_rendersUserFromApi() throws{
    
        let sut = try makeSut()
        sut.loadViewIfNeeded()
        let exp = expectation(description: "Wait For Api")
        exp.isInverted = true
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 200)
    }
    private func makeSut() throws -> ViewController{
        let bundle = Bundle(for: ViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap(initialVC as? UINavigationController)
        
        return try XCTUnwrap(navigation.topViewController as? ViewController)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
