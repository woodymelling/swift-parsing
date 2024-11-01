//
//  AsyncConversion.swift
//  swift-parsing
//
//  Created by Woodrow Melling on 11/1/24.
//



@rethrows public protocol AsyncConversion<Input, Output> {
  // The type of values this conversion converts from.
  associatedtype Input

  // The type of values this conversion converts to.
  associatedtype Output
  func apply(_ input: Input) async throws -> Output
  func unapply(_ input: Output) async throws -> Input
}

