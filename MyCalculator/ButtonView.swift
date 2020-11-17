//
//  ButtonView.swift
//  MyCalculator
//
//  Created by John Miner on 11/11/20.
//

import SwiftUI

struct myButton: View{
    let button: CalculatorButton
    @Binding var state: CalculationState
    var height: CGFloat = (UIScreen.main.bounds.width - 10 * 4) / 4
    var body: some View {
        Button(action: {
            print(self.tapped())
        }, label: {
            Text(self.button.rawValue).frame(width: self.button.width, height: self.height, alignment: .center)
                .background(self.button.backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(self.height)
                .font(.title)
        })
    }
    func tapped() {
        switch button {
        case .ac:
            state.currentNumber = ["+","0"]
            state.storedNumber = nil
            state.storedAction = nil
            break
        case .equals:
            if let storedNumber = state.storedNumber {
                if let action = state.storedAction {
                    switch action {
                    case .plus:
                        state.currentNumber = Array(String(storedNumber + (Double(String(state.currentNumber)) ?? 0.00)))
                        state.storedNumber = nil
                        state.storedAction = nil
                    case .minus:
                        state.currentNumber = Array(String(storedNumber - (Double(String(state.currentNumber)) ?? 0.00)))
                        state.storedNumber = nil
                        state.storedAction = nil
                    case .multiply:
                        state.currentNumber = Array(String(storedNumber * (Double(String(state.currentNumber)) ?? 0.00)))
                        state.storedNumber = nil
                        state.storedAction = nil
                    case .divide:
                        state.currentNumber = Array(String(storedNumber / (Double(String(state.currentNumber)) ?? 0.00)))
                        state.storedNumber = nil
                        state.storedAction = nil
                    default:
                        break
                    }
                }
            }
            
            break
        case .percent:
            break
        case .plus:
            state.storedAction = CalculatorButton.plus
            state.storedNumber = Double(String(state.currentNumber))
            state.currentNumber = ["+","0"]
        case .minus:
            state.storedAction = CalculatorButton.minus
            state.storedNumber = Double(String(state.currentNumber))
            state.currentNumber = ["+","0"]
        case .multiply:
            state.storedAction = CalculatorButton.multiply
            state.storedNumber = Double(String(state.currentNumber))
            state.currentNumber = ["+","0"]
        case .divide:
            state.storedAction = CalculatorButton.divide
            state.storedNumber = Double(String(state.currentNumber))
            state.currentNumber = ["+","0"]
        case .plusMinus:
            if state.currentNumber[0] == "+"{
                state.currentNumber[0] = "-"
            } else if state.currentNumber[0] == "-"{
                state.currentNumber[0] = "+"
            } else {
                state.currentNumber.insert("-", at: 0)
            }
        default:
            state.appendNumber(num: Character(button.rawValue))
        }
        
    }
}
enum CalculatorButton: String{
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case equals = "="
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
    case percent = "%"
    case ac = "AC"
    case plusMinus = "+/-"
    case dot = "."
    var backgroundColor: Color{
        switch self {
        case .equals, .plus, .minus, .multiply, .divide:
            return Color(.green)
        case .ac, .plusMinus, .percent:
            return Color(.gray)
        default:
            return Color(.blue)
            
        }
    }
    var width: CGFloat{
        switch self {
        case .zero:
            return (UIScreen.main.bounds.width - 10 * 4) / 2 + 10
        default:
            return (UIScreen.main.bounds.width - 10 * 4) / 4
        }
    }
}
