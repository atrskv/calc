import XCTest

class CalculatorUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
        
    private func tap(_ identifier: String) {
        let button = app.buttons[identifier]
        XCTAssertTrue(button.exists, "Кнопка \(identifier) не найдена")
        button.tap()
    }
    
    private func result() -> String {
        let display = app.staticTexts["result"]
        XCTAssertTrue(display.exists, "Дисплей не найден")
        return display.label
    }
        
    func testAddition() {
        tap("button5")
        tap("buttonPlus")
        tap("button3")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "8", "5 + 3 = 8")
    }
    
    func testSubtraction() {
        tap("button1")
        tap("button0")
        tap("buttonMinus")
        tap("button4")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "6", "10 - 4 = 6")
    }
    
    func testMultiplication() {
        tap("button7")
        tap("buttonMultiply")
        tap("button6")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "42", "7 × 6 = 42")
    }
    
    func testDivision() {
        tap("button1")
        tap("button5")
        tap("buttonDivide")
        tap("button3")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "5", "15 ÷ 3 = 5")
    }
    
    func testDivisionByZero() {
        tap("button8")
        tap("buttonDivide")
        tap("button0")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "Error", "8 ÷ 0 = Error")
    }
    
    func testClear() {
        
        // WHEN
        tap("button7")
        tap("button8")
        tap("button9")
        
        // THEN
        XCTAssertEqual(result(), "789")
        
        // AND WHEN
        tap("buttonClear")
        
        // AND THEN
        XCTAssertEqual(result(), "0", "0")
    }
    
    func testDecimalNumbers() {
        tap("button2")
        tap("buttonDecimal")
        tap("button5")
        tap("buttonPlus")
        tap("button1")
        tap("buttonDecimal")
        tap("button5")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "4", "2.5 + 1.5 = 4")
    }
    
    func testPlusMinus() {
        // WHEN
        tap("button9")
        tap("buttonPlusMinus")
        
        // THEN
        XCTAssertEqual(result(), "-9", "9 → -9")
        
        // AND WHEN
        tap("buttonPlusMinus")
        
        // AND THEN
        XCTAssertEqual(result(), "9", "-9 → 9")
    }
    
    func testPercent() {
        tap("button2")
        tap("button5")
        tap("buttonPercent")
        
        XCTAssertEqual(result(), "0.25", " 25% = 0.25")
    }
    
    func testMultipleOperations() {
        tap("button4")
        tap("buttonPlus")
        tap("button5")
        tap("buttonMultiply")
        tap("button2")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "18", "4 + 5 × 2 = 18")
    }
    
    func testChainedCalculations() {
        // WHEN
        tap("button6")
        tap("buttonPlus")
        tap("button4")
        tap("buttonEquals")
        
        // THEN
        XCTAssertEqual(result(), "10", "6 + 4 = 10")
        
        // AND WHEN
        tap("buttonDivide")
        tap("button2")
        tap("buttonEquals")
        
        // AND THEN
        XCTAssertEqual(result(), "5", "10 ÷ 2 = 5")
    }
    
    func testZeroHandling() {
        tap("button0")
        tap("buttonPlus")
        tap("button7")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "7", "0 + 7 = 7")
    }
    
    func testComplexCalculation() {
        tap("button5")
        tap("buttonPlus")
        tap("button3")
        tap("buttonEquals")
        tap("buttonMultiply")
        tap("button2")
        tap("buttonEquals")
        tap("buttonMinus")
        tap("button4")
        tap("buttonEquals")
        
        XCTAssertEqual(result(), "12", "(5 + 3) × 2 - 4 = 12")
    }
    
    func testDecimalChain() {
        tap("button0")
        tap("buttonDecimal")
        tap("button1")
        tap("buttonPlus")
        tap("button0")
        tap("buttonDecimal")
        tap("button2")
        tap("buttonEquals")
        
        let result = result()
        XCTAssertTrue(result.hasPrefix("0.3"), "0.1 + 0.2 = ~0.3")
    }
}
