## 0.0.13

## 0.0.12

### Breaking Changes

* The flow state variants of `isBarrier` and `isAdditionalFlowStep` are no longer exposed in the taint tracking library. The `isSanitizer` and `isAdditionalTaintStep` predicates should be used instead.

### Deprecated APIs

* Many classes/predicates/modules that had upper-case acronyms have been renamed to follow our style-guide. 
  The old name still exists as a deprecated alias.

### New Features

* The data flow and taint tracking libraries have been extended with versions of `isBarrierIn`, `isBarrierOut`, and `isBarrierGuard`, respectively `isSanitizerIn`, `isSanitizerOut`, and `isSanitizerGuard`, that support flow states.

### Minor Analysis Improvements

* `getConstantValue()` now returns the contents of strings and symbols after escape sequences have been interpreted. For example, for the Ruby string literal `"\n"`, `getConstantValue().getString()` previously returned a QL string with two characters, a backslash followed by `n`; now it returns the single-character string "\n" (U+000A, known as newline).
* `getConstantValue().getInt()` previously returned incorrect values for integers larger than 2<sup>31</sup>-1 (the largest value that can be represented by the QL `int` type). It now returns no result in those cases.
* Added `OrmWriteAccess` concept to model data written to a database using an object-relational mapping (ORM) library.

## 0.0.11

### Minor Analysis Improvements

* The `Regex` class is now an abstract class that extends `StringlikeLiteral` with implementations for `RegExpLiteral` and string literals that 'flow' into functions that are known to interpret string arguments as regular expressions such as `Regex.new` and `String.match`.
* The regular expression parser now groups sequences of normal characters. This reduces the number of instances of `RegExpNormalChar`.

## 0.0.10

### Minor Analysis Improvements

* Added `FileSystemWriteAccess` concept to model data written to the filesystem.

## 0.0.9

## 0.0.8

## 0.0.7

## 0.0.6

### Deprecated APIs

* `ConstantWriteAccess.getQualifiedName()` has been deprecated in favor of `getAQualifiedName()` which can return multiple possible qualified names for a given constant write access.

## 0.0.5

### New Features

* A new library, `Customizations.qll`, has been added, which allows for global customizations that affect all queries.

## 0.0.4
