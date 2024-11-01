//
//  Convert.swift
//  OpenFestival
//
//  Created by Woodrow Melling on 10/31/24.
//

import Parsing


public struct Convert<Input, Output>: Conversion {
    var _apply: (Input) throws -> Output
    var _unapply: (Output) throws -> Input

    public init(apply: @escaping (Input) throws -> Output, unapply: @escaping (Output) throws -> Input) {
        self._apply = apply
        self._unapply = unapply
    }

    public init<C: Conversion<Input, Output>>(@ConversionBuilder build: () -> C) {
        let conversion = build()
        self._apply = conversion.apply
        self._unapply = conversion.unapply
    }

    
    public func apply(_ input: Input) throws -> Output {
        try self._apply(input)
    }

    public func unapply(_ output: Output) throws -> Input {
        try self._unapply(output)
    }
}
