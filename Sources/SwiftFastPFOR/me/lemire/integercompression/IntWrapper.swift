/**
 * This code is released under the
 * Apache License Version 2.0 http://www.apache.org/licenses/.
 *
 */

extension me.lemire.integercompression {
  
  /**
   * Essentially a mutable wrapper around an integer.
   *
   * @author dwu
   */
  public final class IntWrapper : CustomStringConvertible { //Number {

    private var value : Int
    
    /**
     * Constructor: value set to 0.
     */
    public init() {
      self.value = 0
    }
    
    /**
     * Construction: value set to provided argument.
     *
     * - Parameters:
     * - Parameter v  value to wrap
     */
    public init(_ v : Int) {
      self.value = v
    }
    
    /**
     * add the provided value to the integer
     * @param v value to add
     */
    public func add(_ v : Int) {
      self.value += v
    }
    
    public func doubleValue() -> Double{
      return Double(self.value)
    }
    
    public func floatValue() -> Float {
      return Float(self.value)
    }
    
    /**
     * @return the integer value
     */
    public func get() -> Int{
      return self.value
    }
    
    /**
     * add 1 to the integer value
     */
    public func increment() {
      self.value += 1
    }
    
    public func intValue() -> Int {
      return self.value
    }
    
    public func longValue() -> Int64 {
      return Int64(self.value)
    }
    
    /**
     * Set the value to that of the specified integer.
     *
     * - Parameters:
     * - Parameter newValue specified integer value
     */
    public func set(_ newValue : Int) {
      self.value = newValue
    }
    
    public func toString() -> String {
      return self.description
    }
    
    public var description: String {
      get {
        String (self.value)
      }
    }
  }
}
