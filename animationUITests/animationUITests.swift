//
//  animationUITests.swift
//  animationUITests
//
//  Created by Ibrahim Berat Kaya on 23.03.2021.
//

import XCTest

class animationUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateCircleWithoutInputs() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Click create without giving inputs.
        app.buttons["create"].tap()
        
        // Expect an alert.
        expectAlert(app)
    }
    
    func testCreateCircleWithIncorrectInputs() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Write an incorrect value.
        let xTextField = app.textFields["xValueField"]
        tapAndWrite(field: xTextField, text: "abc")
        
        // Write a correct value.
        let yTextField = app.textFields["yValueField"]
        tapAndWrite(field: yTextField, text: "120")
        
        // Click create.
        app.buttons["create"].tap()
        
        // Expect an alert.
        expectAlert(app)
    }
    
    func testCreateCircleWithCorrectInputs() throws {
        let app = XCUIApplication()
        app.launch()

        // Give correct X input.
        let xTextField = app.textFields["xValueField"]
        tapAndWrite(field: xTextField, text: "120")
        
        // Give correct Y input.
        let yTextField = app.textFields["yValueField"]
        tapAndWrite(field: yTextField, text: "300")
        
        // Click create.
        app.buttons["create"].tap()
        
        // Expect no alerts.
        XCTAssert(app.alerts.count == 0)
        
        // Expect that the circle is drawn.
        XCTAssert(app.otherElements["circle_1"].exists)
    }
    
    func testCreateRectangleWithCorrectInputs() throws {
        let app = XCUIApplication()
        app.launch()

        // Select the Square button on the segment control.
        let segmentControl = app.segmentedControls["segmentControl"]
        XCTAssertTrue(segmentControl.exists)
        XCTAssertTrue(segmentControl.buttons.count > 0)
        segmentControl.buttons["Square"].tap()

        // Give correct X input.
        let xTextField = app.textFields["xValueField"]
        tapAndWrite(field: xTextField, text: "120")
        
        // Give correct Y input.
        let yTextField = app.textFields["yValueField"]
        tapAndWrite(field: yTextField, text: "300")
        
        // Click create.
        app.buttons["create"].tap()
        
        // Expect no alerts.
        XCTAssert(app.alerts.count == 0)
        
        // Expect that the circle is drawn.
        XCTAssert(app.otherElements["rectangle_1"].exists)
    }
    
    func testRandomDraw() {
        let app = XCUIApplication()
        app.launch()

        // Click the Random Draw button.
        app.buttons["randomDraw"].tap()
        
        // Expect no alerts.
        XCTAssert(app.alerts.count == 0)
        
        // Expect that the circle is drawn.
        XCTAssert(app.otherElements["circle_1"].exists)
    }
    
    func testMultipleRandomDraw() {
        let app = XCUIApplication()
        app.launch()

        //Draw random 4 circles.
        for _ in 0 ... 4 {
            // Click the Random Draw button.
            app.buttons["randomDraw"].tap()
        }

        // Select the Square button on the segment control.
        let segmentControl = app.segmentedControls["segmentControl"]
        XCTAssertTrue(segmentControl.exists)
        XCTAssertTrue(segmentControl.buttons.count > 0)
        segmentControl.buttons["Square"].tap()
        
        //Draw random 4 rectangles.
        for _ in 0 ... 4 {
            // Click the Random Draw button.
            app.buttons["randomDraw"].tap()
        }
        
        //Expect 4 circles and 4 rectangles.
        for i in 0 ... 4 {
            // Expect that the circle is drawn.
            XCTAssert(app.otherElements["circle_\(i+1)"].exists)
            XCTAssert(app.otherElements["rectangle_\(i+1)"].exists)
        }

    }
    
    func drawMultipleRandomCirclesAndRectangles() {
        let app = XCUIApplication()
        app.launch()

        // Click the Random Draw button.
        app.buttons["randomDraw"].tap()
        
        // Expect no alerts.
        XCTAssert(app.alerts.count == 0)
        
        // Click the Random Draw button again.
        app.buttons["randomDraw"].tap()
        
        // Expect no alerts.
        XCTAssert(app.alerts.count == 0)
        
        // Expect that the fist circle is drawn.
        XCTAssert(app.otherElements["circle_1"].exists)

        // Expect that the second circle is drawn.
        XCTAssert(app.otherElements["circle_2"].exists)
    }
    
    // Expect an alert and dismiss it.
    func expectAlert(_ app: XCUIApplication) {
        // Expect an alert.
        XCTAssert(app.alerts.count > 0)
        
        // Dismiss the alert.
        app.buttons["OK"].tap()
        
        // Expect alert to be dismissed.
        XCTAssert(app.alerts.count == 0)
    }
    
    // Write to a XCUIElement (generally a TextField).
    func tapAndWrite(field: XCUIElement, text: String) {
        XCTAssertTrue(field.exists, "\(field.label) XCUIElement doesn't exist")
        field.tap()
        field.typeText(text)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
