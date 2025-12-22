import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var currentNumber: String = "0"
    private var previousNumber: Double = 0
    private var currentOperation: String = ""
    private var shouldResetScreen = false
    private var isPerformingOperation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        guard let digit = sender.titleLabel?.text else { return }
        
        if isPerformingOperation {
            currentNumber = digit
            isPerformingOperation = false
            shouldResetScreen = false
        } else if shouldResetScreen {
            currentNumber = digit
            shouldResetScreen = false
        } else {
            if currentNumber == "0" {
                currentNumber = digit
            } else {
                currentNumber += digit
            }
        }
        
        displayLabel.text = currentNumber
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if isPerformingOperation {
            currentNumber = "0."
            isPerformingOperation = false
            shouldResetScreen = false
        } else if shouldResetScreen {
            currentNumber = "0."
            shouldResetScreen = false
        } else if !currentNumber.contains(".") {
            currentNumber += "."
        }
        
        displayLabel.text = currentNumber
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        currentNumber = "0"
        previousNumber = 0
        currentOperation = ""
        isPerformingOperation = false
        shouldResetScreen = false
        displayLabel.text = "0"
    }
    
    @IBAction func plusMinusPressed(_ sender: UIButton) {
        if var number = Double(currentNumber) {
            number *= -1
            currentNumber = String(format: "%g", number)
            displayLabel.text = currentNumber
        }
    }
    
    @IBAction func percentPressed(_ sender: UIButton) {
        if var number = Double(currentNumber) {
            number /= 100
            currentNumber = String(format: "%g", number)
            displayLabel.text = currentNumber
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard let operation = sender.titleLabel?.text else { return }
        
        if !currentOperation.isEmpty && !shouldResetScreen {
            calculate()
        } else {
            previousNumber = Double(currentNumber) ?? 0
        }
        
        currentOperation = operation
        shouldResetScreen = true
        isPerformingOperation = true
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        if !currentOperation.isEmpty {
            calculate()
            currentOperation = ""
        }
        isPerformingOperation = true
    }
    
    private func calculate() {
        let current = Double(currentNumber) ?? 0
        
        switch currentOperation {
        case "+":
            previousNumber = previousNumber + current
        case "-":
            previousNumber = previousNumber - current
        case "×":
            previousNumber = previousNumber * current
        case "÷":
            if current != 0 {
                previousNumber = previousNumber / current
            } else {
                displayLabel.text = "Error"
                currentNumber = "0"
                previousNumber = 0
                currentOperation = ""
                shouldResetScreen = true
                isPerformingOperation = false
                return
            }
        default:
            return
        }
        
        if floor(previousNumber) == previousNumber {
            currentNumber = String(format: "%.0f", previousNumber)
        } else {
            currentNumber = String(format: "%.10g", previousNumber)
        }
        
        displayLabel.text = currentNumber
        shouldResetScreen = true
    }
}
