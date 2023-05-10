//
//  LululemonTechAssesmentSufiAhmedTests.swift
//  LululemonTechAssesmentSufiAhmedTests
//
//  Created by Sufiyan Ahmed on 5/10/23.
//

import XCTest
@testable import LululemonTechAssesmentSufiAhmed

class LululemonTechAssesmentSufiAhmedTests: XCTestCase {
    
    var homeView: HomeView!
    var coreDataManger: GarmentStoreManger!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        homeView = HomeView()
        coreDataManger = GarmentStoreManger()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeView = nil
        coreDataManger = nil
        try super.tearDownWithError()
    }

    //Test for adding new garment
    func testAddNewGarment() throws {
        coreDataManger.addNewGarment("Shirt")
        let store = coreDataManger.fetchGarments()
        let index = store.count - 1
        
        XCTAssertEqual(store[index].garmentName, "Shirt")
    }
    
    //Test for updating existing garment
    func testUpdateGarment() throws {
         var garments = coreDataManger.fetchGarments()
        
        garments[0].garmentName = "ShirtOne"
        coreDataManger.updateGarment()
        
        XCTAssertEqual(garments[0].garmentName, "ShirtOne")
    }
    
    //test for fetching all garments
    func testFetchGarmentData() throws {
        coreDataManger.addNewGarment("Pant")
        let garments = coreDataManger.fetchGarments()
        
       XCTAssertNotNil(garments)
    }
    
    //simple sort test for names
    func testAlphabeticSorting() throws {
        var unSortedArray = ["Sufi", "David", "Tony", "Tim"]
        
        unSortedArray.sort {
            $0.lowercased() < $1.lowercased()
        }
        
        XCTAssertEqual(unSortedArray, ["David", "Sufi", "Tim", "Tony"])
    }
    
    //simple sort test for dates
    func testDateSorting() throws {
        var unSortedArray = ["2023-02-22", "2021-04-18", "2022-01-07", "2022-08-11"]

        unSortedArray.sort {
            $0 < $1
        }
        XCTAssertEqual(unSortedArray, ["2021-04-18", "2022-01-07", "2022-08-11", "2023-02-22"])
    }
    
    //Test to delete all garments
    func testDeleteAllGarment() throws {
        coreDataManger.fetchGarments().forEach { index in
            coreDataManger.deleteGarment(clothes: index)
        }
        
        let garment = coreDataManger.fetchGarments()
       
       XCTAssertEqual(garment.count, 0)
   }
    
    
}
