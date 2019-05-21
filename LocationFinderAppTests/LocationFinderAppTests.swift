//
//  LocationFinderAppTests.swift
//  LocationFinderAppTests
//
//  Created by Atul Bhaisare on 5/21/19.
//  Copyright © 2019 Atul Bhaisare. All rights reserved.
//

import XCTest
import CoreLocation
import CoreData

@testable import LocationFinderApp
class LocationFinderAppTests: XCTestCase {
    var place : Place?
    var appDelegate : AppDelegate?
    var locationObj : Location?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let address = "22425 Market Street Cornelius, NC 28031"
        let description = "Home"
        let location = CLLocation(latitude: 10.00000, longitude: 10.00000)
        place = Place(address: address, description: description, location: location)
        appDelegate =  UIApplication.shared.delegate as? AppDelegate
        locationObj = Location(context: CoreDataStack.sharedManager.mainContext)
        locationObj?.address = "22425 Market Street Cornelius, NC 28031"
        locationObj?.locationDescription = "My Home"
        locationObj?.latitude = 48.0000
        locationObj?.longitude = 54.0000
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        place = nil
        appDelegate = nil
        locationObj = nil
    }

    func testSelectedLocation() {
        XCTAssertTrue(place?.address == "22425 Market Street Cornelius, NC 28031")
        XCTAssertTrue(place?.description == "Home")
    }

    func testCoreDataInitialization()  {
        //XCTAssertTrue(CoreDataStack.sharedManager.mainContext )
        XCTAssertNotNil(CoreDataStack.sharedManager.mainContext)
    }

    func testGMSServices() {
        XCTAssertNotNil(appDelegate?.initializeGMS)
    }
    
    func testCoreDataFunctionality()  {
     CoreDataStack.sharedManager.saveContext()
     let  fetchrequest  =  NSFetchRequest<Location>(entityName: "Location")
       // let array = try CoreDataStack.sharedManager.mainContext.fetch(fetchrequest)
        do {
            let array = try CoreDataStack.sharedManager.mainContext.fetch(fetchrequest)
            for item  in array {
                XCTAssertTrue(item == locationObj)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func testCoreDataDeleteFunctionality()  {
        if let locationObject = locationObj {
            CoreDataStack.sharedManager.mainContext.delete(locationObject)
        }
        let  fetchrequest  =  NSFetchRequest<Location>(entityName: "Location")
        // let array = try CoreDataStack.sharedManager.mainContext.fetch(fetchrequest)
        do {
            let array = try CoreDataStack.sharedManager.mainContext.fetch(fetchrequest)
            for item  in array {
                XCTAssertTrue(item == locationObj)
            }
        }
        catch {
            print(error.localizedDescription)
        }

        
    }
}
