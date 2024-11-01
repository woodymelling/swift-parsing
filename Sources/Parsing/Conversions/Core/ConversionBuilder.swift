//
//  ConversionBuilder.swift
//  swift-parsing
//
//  Created by Woodrow Melling on 10/24/24.
//

@resultBuilder
public struct ConversionBuilder {
  public static func buildBlock<T>() -> Conversions.Identity<T> {
    Conversions.Identity()
  }

  public static func buildPartialBlock<C: Conversion>(first conversion: C) -> C {
      conversion
  }

  public static func buildPartialBlock<C1: Conversion, C2: Conversion>
  (accumulated c1: C1, next c2: C2) -> Conversions.Map<C1, C2> where C1.Output == C2.Input {
    Conversions.Map(upstream: c1, downstream: c2)
  }
}


