/**
 * This code is released under the
 * Apache License Version 2.0 http://www.apache.org/licenses/.
 *
 * (c) Daniel Lemire, http://lemire.me/en/
 */

package me.lemire.longcompression;

import java.util.stream.LongStream;

import org.junit.Assert;
import org.junit.Test;

/**
 * Edge-cases to be tested on a per-codec basis
 * 
 * @author Benoit Lacelle
 */
public abstract class ATestLongCODEC {
	protected void checkConsistency(LongCODEC codec, long[] array) {
		{
			long[] compressed = LongTestUtils.compress(codec, array);
			long[] uncompressed = LongTestUtils.uncompress(codec, compressed, array.length);

			Assert.assertArrayEquals(array, uncompressed);
		}

		if (codec instanceof ByteLongCODEC) {
			byte[] compressed = LongTestUtils.compress((ByteLongCODEC) codec, array);
			long[] uncompressed = LongTestUtils.uncompress((ByteLongCODEC) codec, compressed, array.length);

			Assert.assertArrayEquals(array, uncompressed);
		}

		if (codec instanceof SkippableLongCODEC) {
			long[] compressed = LongTestUtils.compressHeadless((SkippableLongCODEC) codec, array);
			long[] uncompressed =
					LongTestUtils.uncompressHeadless((SkippableLongCODEC) codec, compressed, array.length);

			Assert.assertArrayEquals(array, uncompressed);
		}
	}

	public abstract LongCODEC getCodec();

	@Test
	public void testCodec_Minus1() {
		checkConsistency(getCodec(), new long[] { -1 });
	}

	@Test
	public void testCodec_ZeroTimes8Minus1() {
		checkConsistency(getCodec(), new long[] { 0, 0, 0, 0, 0, 0, 0, 0, -1 });
	}

	@Test
	public void testCodec_ZeroTimes127Minus1() {
		long[] array = LongStream.concat(LongStream.range(0, 127).map(l -> 0), LongStream.of(-1)).toArray();

		checkConsistency(getCodec(), array);
	}

	@Test
	public void testCodec_ZeroTimes128Minus1() {
		long[] array = LongStream.concat(LongStream.range(0, 128).map(l -> 0), LongStream.of(-1)).toArray();

		checkConsistency(getCodec(), array);
	}

	@Test
	public void testCodec_MinValue() {
		checkConsistency(getCodec(), new long[] { Long.MIN_VALUE });
	}

	@Test
	public void testCodec_ZeroMinValue() {
		checkConsistency(getCodec(), new long[] { 0, Long.MIN_VALUE });
	}

	@Test
	public void testCodec_allPowerOfTwo() {
		checkConsistency(getCodec(), new long[] { 1L << 42 });
		for (int i = 0; i < 64; i++) {
			checkConsistency(getCodec(), new long[] { 1L << i });
		}
	}

	@Test
	public void testCodec_ZeroThenAllPowerOfTwo() {
		for (int i = 0; i < 64; i++) {
			checkConsistency(getCodec(), new long[] { 0, 1L << i });
		}
	}

}
