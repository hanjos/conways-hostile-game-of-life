package org.sbrubbles.util 
{
	/**
	 * A bunch of utilitary methods.
	 * 
	 * @author Humberto Anjos
	 */
	public class Util 
	{
		public function Util() {}
		
		/**
		 * Adds an alpha component to a RGB color.
		 * 
		 * @param alpha the alpha value.
		 * @param rgb the color in RGB.
		 * @return the given color in ARGB.
		 */
		public static function addAlphaTo(alpha:uint, rgb:uint):uint
		{
			return (alpha * (1 << 24)) | rgb
		}
	}

}