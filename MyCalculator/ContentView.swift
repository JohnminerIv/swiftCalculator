//
//  ContentView.swift
//  MyCalculator
//
//  Created by John Miner on 11/9/20.
//

import SwiftUI

struct CalculationState{
    var currentNumber: [Character] = ["+","0"]
    var storedNumber: Double?
    var storedAction: CalculatorButton?
    mutating func appendNumber(num: Character) {
        if String(self.currentNumber) == "+0" || String(self.currentNumber) == "-0"{
            currentNumber = ["+", num]
        } else {
            self.currentNumber.append(num)
        }
    }
}

struct ContentView: View {
    @State var calculationState: CalculationState = CalculationState()
    var total: Double = 0
    let buttonOptions: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    var body: some View {
        VStack{
            HStack{
                Text(String(calculationState.currentNumber)).font(.system(size: 80))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 30)
            }
            ForEach(buttonOptions, id: \.self){row in
                HStack{
                    ForEach(row, id: \.self){button in
                        myButton(button: button, state: $calculationState)
                    }
                }.padding(1)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom).padding(.bottom,15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
