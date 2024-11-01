//
//  Convert.swift
//  OpenFestival
//
//  Created by Woodrow Melling on 10/31/24.
//



public struct Convert<Input, Output>: Conversion {
  public var _apply: (Input) throws -> Output
  public var _unapply: (Output) throws -> Input

  public init(apply: @escaping (Input) throws -> Output, unapply: @escaping (Output) throws -> Input) {
    self._apply = apply
    self._unapply = unapply
  }

  public init<C: Conversion<Input, Output>>(@ConversionBuilder build: () -> C) {
    let conversion = build()
    self._apply = conversion.apply
    self._unapply = conversion.unapply
  }


  @inlinable
  @inline(__always)
  public func apply(_ input: Input) throws -> Output {
    try self._apply(input)
  }

  @inlinable
  @inline(__always)
  public func unapply(_ output: Output) throws -> Input {
    try self._unapply(output)
  }
}
