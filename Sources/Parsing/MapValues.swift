//
//  MapValues.swift
//  OpenFestival
//
//  Created by Woodrow Melling on 10/31/24.
//

import Parsing


extension Conversions {
    public struct MapValues<C: Conversion>: Conversion {
        var transform: C

        public init(_ transform: C) {
            self.transform = transform
        }

        public init(@ConversionBuilder _ build: () -> C) {
            self.transform = build()
        }

        public func apply(_ input: [C.Input]) throws -> [C.Output] {
            try input.map(transform.apply)
        }

        public func unapply(_ output: [C.Output]) throws -> [C.Input] {
            try output.map(transform.unapply)
        }
    }


    public struct MapKVPairs<KeyConversion: Conversion, ValueConversion: Conversion>: Conversion where KeyConversion.Input: Hashable, KeyConversion.Output: Hashable {
        public typealias Input = [KeyConversion.Input: ValueConversion.Input]
        public typealias Output = [KeyConversion.Output: ValueConversion.Output]

        var keyConversion: KeyConversion
        var valueConversion: ValueConversion
      
      public init(keyConversion: KeyConversion, valueConversion: ValueConversion) {
        self.keyConversion = keyConversion
        self.valueConversion = valueConversion
      }

        public func apply(_ input: Input) throws -> Output {
            Dictionary(uniqueKeysWithValues: try input.map {
                try (keyConversion.apply($0.0), valueConversion.apply($0.1))
            })

        }

        public func unapply(_ output: Output) throws -> Input {
            Dictionary(uniqueKeysWithValues: try output.map {
                try (keyConversion.unapply($0.0), valueConversion.unapply($0.1))
            })
        }
    }
}
