//
//  CalculatorBrain.swift
//  SwiftLearnDemo
//
//  Created by baolicheng on 15/12/9.
//  Copyright © 2015年 RenRenFenQi. All rights reserved.
//

import Foundation
class CalculatorBrain
{
    private enum Op : CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double,Double)->Double)
        var description: String{
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init()
    {
        func learnOp(op:Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("+",+))
        
        knownOps["+"] = Op.BinaryOperation("+",+)
        knownOps["-"] = Op.BinaryOperation("-"){$1 - $0}
        knownOps["*"] = Op.BinaryOperation("*",*)
        knownOps["/"] = Op.BinaryOperation("/"){$1 / $0}
        knownOps["z"] = Op.UnaryOperation("z",sqrt)
    }
    
    private func evaluate(ops:[Op]) -> (result:Double?,retainingOps:[Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operationEvaluation = evaluate(remainingOps)
                if let operand = operationEvaluation.result{
                    return (operation(operand), operationEvaluation.retainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.retainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1,operand2),op2Evaluation.retainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result, _) = evaluate(opStack)
        print("\(opStack) = \(result)")
        return result
    }
    
    func pushOperand(operand: Double)  -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol : String) -> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
}