/**
 * This is code is released under the
 * Apache License Version 2.0 http://www.apache.org/licenses/.
 *
 * (c) Daniel Lemire, http://lemire.me/en/
 */

extension me.lemire.integercompression {
  
  
  /**
   * Interface describing a standard CODEC to compress integers. This is a
   * variation on the IntegerCODEC interface meant to be used for random access
   * (i.e., given a large array, you can segment it and decode just the subarray you need).
   *
   * The main difference is that you must specify the number of integers you wish to
   * uncompress. This information should be stored elsewhere.
   *
   * This interface was designed by the Terrier team for their search engine.
   *
   * @author Daniel Lemire
   *
   */
  public protocol SkippableIntegerCODEC {
    /**
     * Compress data from an array to another array.
     *
     * Both inpos and outpos are modified to represent how much data was read
     * and written to. If 12 ints (inlength = 12) are compressed to 3 ints, then
     * inpos will be incremented by 12 while outpos will be incremented by 3. We
     * use IntWrapper to pass the values by reference.
     *
     * Implementation note: contrary to {@link IntegerCODEC#compress},
     * this may skip writing information about the number of encoded integers.
     *
     * @param in
     *            input array
     * @param inpos
     *            where to start reading in the array
     * @param inlength
     *            how many integers to compress
     * @param out
     *            output array
     * @param outpos
     *            where to write in the output array
     */
    func headlessCompress (_ inJ : [Int], _ inpos : IntWrapper, _ inlength : Int, _ outJ : [Int], _ outpos : IntWrapper)
    
    /**
     * Uncompress data from an array to another array.
     *
     * Both inpos and outpos parameters are modified to indicate new positions
     * after read/write.
     *
     * @param in
     *            array containing data in compressed form
     * @param inpos
     *            where to start reading in the array
     * @param inlength
     *            length of the compressed data (ignored by some schemes)
     * @param out
     *            array where to write the uncompressed output
     * @param outpos
     *            where to start writing the uncompressed output in out
     * @param num
     *            number of integers we want to decode. May be less than the actual number of compressed integers
     */
    func headlessUncompress (_ inJ : [Int], _ inpos : IntWrapper, _ inlength : Int, outJ : [Int], _ outpos : IntWrapper, _ num : Int)
    
  }
}
